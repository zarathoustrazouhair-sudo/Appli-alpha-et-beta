import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../presentation/settings_controller.dart';
import '../../../../data/repositories/resident_repository.dart';

class SettingsFormScreen extends ConsumerStatefulWidget {
  const SettingsFormScreen({super.key});

  @override
  ConsumerState<SettingsFormScreen> createState() => _SettingsFormScreenState();
}

class _SettingsFormScreenState extends ConsumerState<SettingsFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _syndicNameCtrl = TextEditingController();
  final _syndicPhoneCtrl = TextEditingController();
  final _syndicEmailCtrl = TextEditingController();
  final _adjointNameCtrl = TextEditingController();
  final _adjointPhoneCtrl = TextEditingController();
  final _mandateDateCtrl = TextEditingController();

  // New Legal & Financial Fields
  final _residenceNameCtrl = TextEditingController();
  final _jurisdictionCtrl = TextEditingController();
  final _cndpCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _thresholdCtrl = TextEditingController();
  final _fundPercentCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  // RIB Field (Read-Only)
  final _ribCtrl = TextEditingController();

  String? _logoPath;
  String _originalFee = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final config = await ref.read(settingsControllerProvider.future);
    setState(() {
      _logoPath = config['LOGO_PATH'];
      _syndicNameCtrl.text = config['SYNDIC_NAME'] ?? '';
      _syndicPhoneCtrl.text = config['SYNDIC_PHONE'] ?? '';
      _syndicEmailCtrl.text = config['SYNDIC_EMAIL'] ?? '';
      _adjointNameCtrl.text = config['ADJOINT_NAME'] ?? '';
      _adjointPhoneCtrl.text = config['ADJOINT_PHONE'] ?? '';
      _mandateDateCtrl.text = config['MANDATE_START_DATE'] ?? '';

      _residenceNameCtrl.text =
          config['RESIDENCE_NAME'] ?? "RÉSIDENCE L'AMANDIER B";
      _jurisdictionCtrl.text =
          config['JURISDICTION'] ??
          "Tribunal de Première Instance de CASABLANCA";
      _cndpCtrl.text = config['CNDP_NUM'] ?? '';

      _feeCtrl.text = config['MONTHLY_FEE'] ?? '250';
      _originalFee = _feeCtrl.text;

      _thresholdCtrl.text = config['TREASURY_THRESHOLD'] ?? '3000';
      _fundPercentCtrl.text = config['FUND_PERCENT'] ?? '5';
      _cityCtrl.text = config['CITY'] ?? 'Bouskoura';

      // Load RIB from Config (which is now hardcoded/seeded in DB)
      _ribCtrl.text = config['RIB'] ?? '';

      _isLoading = false;
    });
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'logo_custom.png';
      final savedImage = await File(
        xFile.path,
      ).copy(p.join(appDir.path, fileName));
      setState(() {
        _logoPath = savedImage.path;
      });
    }
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(settingsControllerProvider.notifier);

      if (_feeCtrl.text != _originalFee) {
        final newFee = int.tryParse(_feeCtrl.text) ?? 250;
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Mise à jour Cotisations'),
            content: Text(
              'Le montant de la cotisation a changé de $_originalFee à $newFee DH.\nVoulez-vous appliquer ce nouveau tarif à TOUS les résidents actuels ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Non (Futurs seulement)'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Oui (Tout le monde)'),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await ref.read(residentRepositoryProvider).updateAllFees(newFee);
          if (mounted)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tous les résidents ont été mis à jour.'),
              ),
            );
        }
      }

      if (_logoPath != null)
        await notifier.updateConfig('LOGO_PATH', _logoPath!);

      await notifier.updateConfig('SYNDIC_NAME', _syndicNameCtrl.text);
      await notifier.updateConfig('SYNDIC_PHONE', _syndicPhoneCtrl.text);
      await notifier.updateConfig('SYNDIC_EMAIL', _syndicEmailCtrl.text);
      await notifier.updateConfig('ADJOINT_NAME', _adjointNameCtrl.text);
      await notifier.updateConfig('ADJOINT_PHONE', _adjointPhoneCtrl.text);
      await notifier.updateConfig('MANDATE_START_DATE', _mandateDateCtrl.text);

      await notifier.updateConfig('RESIDENCE_NAME', _residenceNameCtrl.text);
      await notifier.updateConfig('JURISDICTION', _jurisdictionCtrl.text);
      await notifier.updateConfig('CNDP_NUM', _cndpCtrl.text);

      await notifier.updateConfig('MONTHLY_FEE', _feeCtrl.text);
      await notifier.updateConfig('TREASURY_THRESHOLD', _thresholdCtrl.text);
      await notifier.updateConfig('FUND_PERCENT', _fundPercentCtrl.text);
      await notifier.updateConfig('CITY', _cityCtrl.text);

      // Do NOT update RIB from here. It is read-only.

      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuration sauvegardée')),
        );

      setState(() {
        _originalFee = _feeCtrl.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'CONFIGURATION SYNDIC',
          style: TextStyle(
            fontFamily: 'Serif',
            letterSpacing: 1.5,
            color: Color(0xFFD4AF37),
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Color(0xFFD4AF37)),
            onPressed: _save,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _pickLogo,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              border: Border.all(
                                color: const Color(0xFFD4AF37),
                              ),
                              shape: BoxShape.circle,
                              image:
                                  _logoPath != null &&
                                      File(_logoPath!).existsSync()
                                  ? DecorationImage(
                                      image: FileImage(File(_logoPath!)),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _logoPath == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Logo Officiel",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildSectionHeader(
                        'IDENTITÉ DU SYNDIC (OFFICIEL)',
                        Icons.person,
                      ),
                      _buildTextField(
                        _syndicNameCtrl,
                        'Nom Complet',
                        Icons.badge,
                      ),
                      _buildTextField(
                        _syndicPhoneCtrl,
                        'Téléphone',
                        Icons.phone,
                        type: TextInputType.phone,
                      ),
                      _buildTextField(
                        _syndicEmailCtrl,
                        'Email',
                        Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      _buildDateField(
                        context,
                        _mandateDateCtrl,
                        'Date Début Mandat',
                      ),

                      const SizedBox(height: 24),
                      _buildSectionHeader('LE BUREAU (ADJOINT)', Icons.group),
                      _buildTextField(
                        _adjointNameCtrl,
                        'Nom Adjoint',
                        Icons.person_outline,
                      ),
                      _buildTextField(
                        _adjointPhoneCtrl,
                        'Téléphone Adjoint',
                        Icons.phone,
                        type: TextInputType.phone,
                      ),

                      const SizedBox(height: 24),
                      _buildSectionHeader('PARAMÈTRES JURIDIQUES', Icons.gavel),
                      _buildTextField(
                        _residenceNameCtrl,
                        'Nom Résidence',
                        Icons.apartment,
                      ),
                      _buildTextField(
                        _jurisdictionCtrl,
                        'Juridiction (Tribunal)',
                        Icons.balance,
                      ),
                      _buildTextField(_cndpCtrl, 'N° CNDP', Icons.security),
                      _buildTextField(_cityCtrl, 'Ville', Icons.location_city),

                      const SizedBox(height: 24),
                      _buildSectionHeader(
                        'PARAMÈTRES FINANCIERS',
                        Icons.account_balance,
                      ),
                      _buildTextField(
                        _feeCtrl,
                        'Cotisation Mensuelle (DH)',
                        Icons.attach_money,
                        type: TextInputType.number,
                      ),
                      _buildTextField(
                        _thresholdCtrl,
                        'Seuil Alerte (DH)',
                        Icons.warning,
                        type: TextInputType.number,
                      ),
                      _buildTextField(
                        _fundPercentCtrl,
                        '% Fonds Travaux',
                        Icons.pie_chart,
                        type: TextInputType.number,
                      ),

                      const SizedBox(height: 16),
                      // RIB READ-ONLY
                      _buildTextField(
                        _ribCtrl,
                        'COORDONNÉES BANCAIRES (OFFICIEL)',
                        Icons.account_balance_wallet,
                        type: TextInputType.multiline,
                        maxLines: 10, // More space
                        readOnly: true, // READ ONLY
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "ℹ️ Ces coordonnées sont fixes pour garantir l'intégrité.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.save),
                        label: const Text('SAUVEGARDER CONFIGURATION'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37)),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        maxLines: maxLines,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.grey) : null,
          prefix: maxLines > 1
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(icon, color: Colors.grey, size: 20),
                )
              : null,
          fillColor: readOnly
              ? Colors.black.withOpacity(0.3)
              : const Color(0xFF1E1E1E), // Visual clue
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: readOnly ? Colors.grey : Colors.white),
        validator: (v) => v!.isEmpty ? 'Requis' : null,
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    TextEditingController ctrl,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
          );
          if (picked != null) {
            ctrl.text = picked.toString().split(' ')[0];
          }
        },
        child: IgnorePointer(
          child: TextFormField(
            controller: ctrl,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              fillColor: const Color(0xFF1E1E1E),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              labelStyle: const TextStyle(color: Colors.grey),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
