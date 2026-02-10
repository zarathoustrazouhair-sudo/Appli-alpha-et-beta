import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../presentation/settings_controller.dart';
import '../../navigation/main_scaffold.dart';

class SetupWizardScreen extends ConsumerStatefulWidget {
  const SetupWizardScreen({super.key});

  @override
  ConsumerState<SetupWizardScreen> createState() => _SetupWizardScreenState();
}

class _SetupWizardScreenState extends ConsumerState<SetupWizardScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Slide 1: Branding
  String? _logoPath;

  // Slide 2: Identity
  final _syndicNameCtrl = TextEditingController();
  final _syndicPhoneCtrl = TextEditingController();
  final _syndicEmailCtrl = TextEditingController();
  final _adjointNameCtrl = TextEditingController();
  final _adjointPhoneCtrl = TextEditingController();
  final _mandateDateCtrl = TextEditingController(
    text: DateTime.now().toString().split(' ')[0],
  );

  // Slide 3: Juridique
  final _residenceNameCtrl = TextEditingController(
    text: "RÉSIDENCE EXEMPLE",
  );
  final _jurisdictionCtrl = TextEditingController(
    text: "Tribunal de Première Instance de CASABLANCA",
  );
  final _cndpCtrl = TextEditingController(text: "En cours");

  // Slide 4: Financier
  final _feeCtrl = TextEditingController(text: "250");
  final _thresholdCtrl = TextEditingController(text: "3000");
  final _fundPercentCtrl = TextEditingController(text: "5");

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

  Future<void> _finishSetup() async {
    final notifier = ref.read(settingsControllerProvider.notifier);

    // Save ALL Configs
    if (_logoPath != null) await notifier.updateConfig('LOGO_PATH', _logoPath!);

    await notifier.updateConfig('SYNDIC_NAME', _syndicNameCtrl.text);
    await notifier.updateConfig('SYNDIC_PHONE', _syndicPhoneCtrl.text);
    await notifier.updateConfig('SYNDIC_EMAIL', _syndicEmailCtrl.text);
    await notifier.updateConfig('MANDATE_START_DATE', _mandateDateCtrl.text);
    await notifier.updateConfig('ADJOINT_NAME', _adjointNameCtrl.text);
    await notifier.updateConfig('ADJOINT_PHONE', _adjointPhoneCtrl.text);

    await notifier.updateConfig('RESIDENCE_NAME', _residenceNameCtrl.text);
    await notifier.updateConfig('JURISDICTION', _jurisdictionCtrl.text);
    await notifier.updateConfig('CNDP_NUM', _cndpCtrl.text);

    await notifier.updateConfig('MONTHLY_FEE', _feeCtrl.text);
    await notifier.updateConfig('TREASURY_THRESHOLD', _thresholdCtrl.text);
    await notifier.updateConfig('FUND_PERCENT', _fundPercentCtrl.text);

    await notifier.updateConfig('IS_SETUP_COMPLETE', 'true');

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'ASSISTANT DE DÉMARRAGE',
          style: TextStyle(
            fontFamily: 'Serif',
            letterSpacing: 1.5,
            color: Color(0xFFD4AF37),
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSlide1(),
                _buildSlide2(),
                _buildSlide3(),
                _buildSlide4(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSlide1() {
    return _SlideContainer(
      title: "1. IDENTITÉ VISUELLE",
      description:
          "Ce logo sera apposé sur tous les actes officiels (PV, Reçus, Mises en demeure).",
      child: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickLogo,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  border: Border.all(color: const Color(0xFFD4AF37)),
                  shape: BoxShape.circle,
                  image: _logoPath != null
                      ? DecorationImage(
                          image: FileImage(File(_logoPath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _logoPath == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _pickLogo,
              child: const Text(
                "Choisir le logo",
                style: TextStyle(color: Color(0xFFD4AF37)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide2() {
    return _SlideContainer(
      title: "2. IDENTITÉ DU SYNDIC",
      description: "Informations légales obligatoires.",
      child: Column(
        children: [
          _WizardField(
            controller: _syndicNameCtrl,
            label: "Nom Complet du Syndic",
          ),
          _WizardField(
            controller: _mandateDateCtrl,
            label: "Début Mandat (AAAA-MM-JJ)",
            icon: Icons.calendar_today,
          ),
          _WizardField(
            controller: _syndicPhoneCtrl,
            label: "Téléphone",
            icon: Icons.phone,
          ),
          _WizardField(controller: _syndicEmailCtrl, label: "Email"),
          const Divider(color: Colors.grey),
          _WizardField(controller: _adjointNameCtrl, label: "Nom de l'Adjoint"),
          _WizardField(
            controller: _adjointPhoneCtrl,
            label: "Tél Adjoint",
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildSlide3() {
    return _SlideContainer(
      title: "3. PARAMÈTRES JURIDIQUES",
      description: "Conformité Loi 18-00 & Décret 2.23.700.",
      child: Column(
        children: [
          _WizardField(
            controller: _residenceNameCtrl,
            label: "Nom de la Résidence",
          ),
          _WizardField(
            controller: _jurisdictionCtrl,
            label: "Juridiction Compétente",
          ),
          _WizardField(controller: _cndpCtrl, label: "N° Autorisation CNDP"),
        ],
      ),
    );
  }

  Widget _buildSlide4() {
    return _SlideContainer(
      title: "4. PARAMÈTRES FINANCIERS",
      description: "Gestion comptable & Seuils d'alerte.",
      child: Column(
        children: [
          _WizardField(
            controller: _feeCtrl,
            label: "Cotisation Mensuelle (DH)",
            icon: Icons.attach_money,
          ),
          _WizardField(
            controller: _thresholdCtrl,
            label: "Seuil Alerte Trésorerie (DH)",
            icon: Icons.warning,
          ),
          _WizardField(
            controller: _fundPercentCtrl,
            label: "% Fonds de Travaux",
            icon: Icons.pie_chart,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                setState(() => _currentStep--);
              },
              child: const Text(
                "Précédent",
                style: TextStyle(color: Colors.grey),
              ),
            ),

          ElevatedButton(
            onPressed: () {
              if (_currentStep < 3) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                setState(() => _currentStep++);
              } else {
                _finishSetup();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
            ),
            child: Text(_currentStep < 3 ? "Suivant" : "TERMINER"),
          ),
        ],
      ),
    );
  }
}

class _SlideContainer extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _SlideContainer({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          child,
        ],
      ),
    );
  }
}

class _WizardField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;

  const _WizardField({
    required this.controller,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null
              ? Icon(icon, color: const Color(0xFFD4AF37))
              : null,
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
