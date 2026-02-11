import 'dart:io';
import '../../../../data/database/database.dart';
import '../../residents/domain/entities/resident.dart' as domain;

abstract class PdfServiceInterface {
  Future<File> generateAppelDeFonds(domain.Resident resident, int amountCents, int quarter, int year);
  Future<File> generateMiseEnDemeure(domain.Resident resident, int debtCents, String randomHash);
  Future<File> generateReceipt(Transaction transaction, String residentName, {String paymentMethod = "Espèces"});
  Future<File> generateConvocationAG(List<String> agendaItems, DateTime date, String location);
  Future<File> generatePouvoir(domain.Resident resident, DateTime agDate);
  Future<File> generatePV(DateTime date, int presentCount, int totalCount, int tantiemes, String quorumStatus, List<Map<String, dynamic>> resolutions);
  Future<File> generateContratConcierge(String employeeName, String cin, double salaryAmount, int workHours, String dayOff);
  Future<File> generateDechargeLogement(String employeeName, DateTime date);
  Future<File> generateConsentementDigital(domain.Resident resident, String lotNumber, String phoneNumber);
  Future<File> generateBonDeCommande(String poNumber, Map<String, dynamic> supplier, List<Map<String, dynamic>> items, String budgetLine, DateTime date);
  Future<File> generateBulletinPaieConcierge(String employeeName, String cin, int month, int year, double baseSalary, double overtime, double housingBenefit, double seniorityBonus, double cnssDeduction, double advances, String cnssRef, String paymentMethod);
  Future<File> generateRecuPrestationMenage(String cleanerName, String cin, String interventionDates, double hours, double rate);
  Future<File> generateJournalCaisse(double bankStart, double bankIn, double bankOut, double cashBalance, double reserveFund, double pendingInvoices, double unpaidDebts);
  Future<File> generateGlobalMatrix(List<domain.Resident> residents, Map<int, Map<int, bool>> paymentMatrix, int year);
}
