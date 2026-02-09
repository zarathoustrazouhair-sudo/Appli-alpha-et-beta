import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ResidentDashboardScreen extends StatefulWidget {
  final String residentName;
  final String residentPhone;
  final String aptNumber;

  const ResidentDashboardScreen({
    super.key,
    required this.residentName,
    required this.residentPhone,
    required this.aptNumber,
  });

  @override
  State<ResidentDashboardScreen> createState() =>
      _ResidentDashboardScreenState();
}

class _ResidentDashboardScreenState extends State<ResidentDashboardScreen> {
  final _supabase = Supabase.instance.client;
  String _buildingStatus = 'LOADING';
  String? _rib;
  List<Map<String, dynamic>> _posts = [];

  // Incident Form
  bool _isAnonymous = false;
  bool _isUrgent = false;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  XFile? _image;

  // HARDCODED RIB (SOURCE OF TRUTH)
  static const String _kStaticRib =
      "1. Pour un virement au Maroc (National)\n"
      "Bénéficiaire : STE SYNDICAT AMANDIER B\n"
      "Banque : BANK OF AFRICA (Agence Bachkou)\n"
      "RIB (24 chiffres) : 011794000051200000374935\n\n"
      "2. Pour un virement de l'étranger (International)\n"
      "Bénéficiaire : STE SYNDICAT AMANDIER B\n"
      "Banque : BANK OF AFRICA - BMCE GROUP\n"
      "Code SWIFT / BIC : BMCEMAMC\n"
      "IBAN (International) : MA64011794000051200000374935";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final health = await _supabase
        .from('building_health')
        .select('status')
        .maybeSingle();
    final postsData = await _supabase
        .from('syndic_posts')
        .select()
        .order('created_at', ascending: false)
        .limit(5);

    if (mounted) {
      setState(() {
        _buildingStatus = health != null ? health['status'] : 'GREEN';
        _rib = _kStaticRib; // Force Static
        _posts = List<Map<String, dynamic>>.from(postsData);
      });
    }
  }

  Future<void> _submitIncident() async {
    if (_titleController.text.isEmpty) return;

    try {
      await _supabase.from('incidents').insert({
        'title': _titleController.text,
        'description': _descController.text,
        'is_anonymous': _isAnonymous,
        'is_urgent': _isUrgent, // VERIFIED: Sends urgency
        'resident_phone': widget.residentPhone,
        'apt_number': widget.aptNumber,
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Incident signalé')));
        _titleController.clear();
        _descController.clear();
        setState(() => _image = null);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }

  Future<void> _triggerSOS() async {
    // 1. Post to Cloud (Silent Alarm)
    try {
      await _supabase.from('incidents').insert({
        'title': "URGENCE VITALE - ${widget.residentName}",
        'description': "Appel SOS déclenché depuis l'application résidents.",
        'is_anonymous': false,
        'is_urgent': true,
        'resident_phone': widget.residentPhone,
        'apt_number': widget.aptNumber,
      });
    } catch (e) {
      // Ignore cloud errors in emergency, prioritize WhatsApp
    }

    // 2. Launch WhatsApp (Concierge)
    final uri = Uri.parse(
      "https://wa.me/212600000000?text=URGENCE%20VITALE%20APPARTEMENT%20${widget.aptNumber}",
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp')),
        );
    }
  }

  Future<void> _showCamera() async {
    try {
      // Fetch URL from Cloud Config
      final config = await _supabase
          .from('app_config')
          .select('value')
          .eq('key', 'camera_url')
          .maybeSingle();

      final url = config != null
          ? config['value']
          : 'https://via.placeholder.com/400x300.png?text=Camera+Offline';

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "CAMÉRA ENTRÉE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Image.network(
                url,
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (ctx, err, _) =>
                    const Icon(Icons.broken_image, color: Colors.red, size: 50),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur Caméra: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGreen = _buildingStatus == 'GREEN';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'Bonjour ${widget.residentName.split(' ')[0]}',
          style: const TextStyle(color: Color(0xFFD4AF37)),
        ),
        backgroundColor: const Color(0xFF121212),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SECURITY MODULE (NEW)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sos, color: Colors.white),
                    label: const Text("SOS / URGENCE"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _triggerSOS,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.videocam, color: Colors.black),
                    label: const Text("CAMÉRA"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _showCamera,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // METEO IMMEUBLE
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isGreen ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isGreen ? Icons.check_circle : Icons.warning,
                    color: isGreen ? Colors.green : Colors.red,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isGreen ? "TOUT VA BIEN" : "SITUATION CRITIQUE",
                    style: TextStyle(
                      color: isGreen ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // INCIDENT REPORT
            const Text(
              "SIGNALER UN INCIDENT",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _isAnonymous = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isAnonymous
                                ? Colors.grey
                                : Colors.transparent,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text('Anonyme'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _isAnonymous = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_isAnonymous
                                ? const Color(0xFFD4AF37)
                                : Colors.transparent,
                            foregroundColor: !_isAnonymous
                                ? Colors.black
                                : Colors.white,
                            side: const BorderSide(color: Color(0xFFD4AF37)),
                          ),
                          child: const Text('Signé'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Titre (ex: Fuite eau)',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: _image != null ? Colors.green : Colors.grey,
                        ),
                        onPressed: () async {
                          final img = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                          );
                          setState(() => _image = img);
                        },
                      ),
                      const Spacer(),
                      Switch(
                        value: _isUrgent,
                        onChanged: (v) => setState(() => _isUrgent = v),
                        activeThumbColor: Colors.red,
                      ),
                      const Text("Urgent", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _submitIncident,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'ENVOYER',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // RIB
            const Text(
              "COORDONNÉES BANCAIRES",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance, color: Color(0xFFD4AF37)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SelectableText(
                      // CHANGED to SelectableText for better UX
                      _rib ?? "Chargement...",
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.grey),
                    onPressed: () {
                      if (_rib != null) {
                        Clipboard.setData(ClipboardData(text: _rib!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('RIB Copié')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // FEED
            const Text(
              "DERNIÈRES COMMUNICATIONS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (_posts.isEmpty)
              const Text(
                "Aucun message du Syndic.",
                style: TextStyle(color: Colors.grey),
              ),
            ..._posts.map(
              (post) => Card(
                color: const Color(0xFF1E1E1E),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    post['title'] ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    post['content'] ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
