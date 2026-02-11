import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/pdf_reports/data/services/eco_pdf_service_impl.dart';
import '../../../../features/residents/data/repositories/resident_repository.dart';
import '../../settings/presentation/settings_controller.dart';
import 'package:printing/printing.dart';

part 'global_report_controller.g.dart';

@riverpod
class GlobalReportController extends _$GlobalReportController {
  @override
  void build() {}

  Future<void> generateAndPrint() async {
    final residentRepo = ref.read(residentRepositoryProvider);
    await ref.read(settingsControllerProvider.future);

    // final residents = await residentRepo.getResidents(); // Unused for now

    // Calculate Balances - Placeholder for future implementation
    /*
    Map<int, double> balances = {};
    for (var r in residents) {
       balances[r.id] = await residentRepo.getResidentBalance(r).first;
    }
    */

    final pdfService = ref.read(pdfServiceProvider);

    // Generate Journal Caisse as the global report
    final pdfFile = await pdfService.generateJournalCaisse(
      0.0, // Solde Jan
      0.0, // Encaissements
      0.0, // Decaissements
      0.0, // Solde Final
      0.0, // Total Dettes
      0.0, // Total Avance
      0.0, // Pending Invoices
    );

    await Printing.layoutPdf(onLayout: (_) => pdfFile.readAsBytes());
  }
}
