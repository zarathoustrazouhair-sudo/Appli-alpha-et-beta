import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dashboard/resident_dashboard_screen.dart';

class ResidentLoginScreen extends StatefulWidget {
  const ResidentLoginScreen({super.key});

  @override
  State<ResidentLoginScreen> createState() => _ResidentLoginScreenState();
}

class _ResidentLoginScreenState extends State<ResidentLoginScreen> {
  int _step = 1;
  String? _selectedFloor;
  String? _selectedApt;
  String? _residentName;
  String? _residentPhone;
  bool _isLoading = false;
  final _pinController = TextEditingController();

  // REALITY MAPPING: 3 FLOORS, 15 APARTMENTS (5 per floor)
  final List<String> _floors = ['1', '2', '3'];

  List<String> _getApartmentsForFloor(String floor) {
    switch (floor) {
      case '1':
        return ['1', '2', '3', '4', '5'];
      case '2':
        return ['6', '7', '8', '9', '10'];
      case '3':
        return ['11', '12', '13', '14', '15'];
      default:
        return [];
    }
  }

  List<String> _apartments = [];

  void _onFloorChanged(String? floor) {
    if (floor == null) return;
    setState(() {
      _selectedFloor = floor;
      _apartments = _getApartmentsForFloor(floor);
      _selectedApt = null;
    });
  }

  Future<void> _fetchResidentName() async {
    if (_selectedApt == null) return;

    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('resident_status')
          .select('resident_name, phone')
          .eq('apt_number', _selectedApt!)
          .maybeSingle();

      if (response != null) {
        if (mounted) {
          setState(() {
            _residentName = response['resident_name'];
            _residentPhone = response['phone'];
            _step = 2;
          });
        }
      } else {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appartement non synchronisé ou vacant.'),
            ),
          );
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur connexion: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyPin() async {
    if (_pinController.text.length != 4) return;

    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('resident_status')
          .select('pin_code')
          .eq('apt_number', _selectedApt!)
          .maybeSingle();

      if (!mounted) return;

      if (response != null && response['pin_code'] == _pinController.text) {
        // SUCCESS SNACKBAR (BEFORE NAV)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Bonjour M./Mme $_residentName. Bienvenue chez vous.",
            ),
            backgroundColor: const Color(0xFFD4AF37),
            duration: const Duration(seconds: 3), // 3 Seconds
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResidentDashboardScreen(
              residentName: _residentName!,
              residentPhone: _residentPhone!,
              aptNumber: _selectedApt!,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Code PIN incorrect.')));
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home_work, size: 80, color: Color(0xFFD4AF37)),
              const SizedBox(height: 20),
              const Text(
                "RÉSIDENCE L'AMANDIER B",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),

              if (_step == 1) ...[
                DropdownButtonFormField<String>(
                  initialValue: _selectedFloor,
                  items: _floors
                      .map(
                        (f) =>
                            DropdownMenuItem(value: f, child: Text("Étage $f")),
                      )
                      .toList(),
                  onChanged: _onFloorChanged,
                  decoration: const InputDecoration(
                    labelText: 'Votre Étage',
                    filled: true,
                    fillColor: Color(0xFF1E1E1E),
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  dropdownColor: const Color(0xFF1E1E1E),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                if (_selectedFloor != null)
                  DropdownButtonFormField<String>(
                    initialValue: _selectedApt,
                    items: _apartments
                        .map(
                          (a) => DropdownMenuItem(
                            value: a,
                            child: Text("Appartement $a"),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _selectedApt = val),
                    decoration: const InputDecoration(
                      labelText: 'Votre Appartement',
                      filled: true,
                      fillColor: Color(0xFF1E1E1E),
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    dropdownColor: const Color(0xFF1E1E1E),
                    style: const TextStyle(color: Colors.white),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: (_selectedApt != null && !_isLoading)
                      ? _fetchResidentName
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('CONTINUER'),
                ),
              ] else ...[
                Text(
                  "Bonjour M./Mme $_residentName",
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 8,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Code Secret (4 chiffres)',
                    counterText: "",
                    filled: true,
                    fillColor: Color(0xFF1E1E1E),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: (!_isLoading) ? _verifyPin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('CONNEXION'),
                ),
                TextButton(
                  onPressed: () => setState(() => _step = 1),
                  child: const Text(
                    'Retour',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
