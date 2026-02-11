class CalculatePaidUntilUseCase {
  static const double monthlyFee = 250.0;

  String execute(double currentBalance, {DateTime? currentDate}) {
    if (currentBalance < 0) {
      return "EN RETARD";
    }

    final now = currentDate ?? DateTime.now();
    // Assuming the balance pays for future months starting from the current month
    // OR assuming "paid until" means covering costs up to a date.
    // Spec: "Si solde >= 0, calculer nombre de mois d'avance (Solde / 250) et projeter la date future."

    int monthsAdvance = (currentBalance / monthlyFee).floor();

    // If balance is 0, it means paid up to now (or rather, end of last month? or start of this month?)
    // Let's assume standard logic: "Paid Until" implies the last fully paid month.
    // If I have 250 DH (1 month), and I am in January. Am I paid for January? Yes.
    // So if balance = 250, paid until = January (Current Month).
    // If balance = 500, paid until = February.
    // If balance = 0, it usually means "Up to date" but not in advance.

    // Refined Logic based on typical Syndic:
    // Balance is usually (Total Paid - Total Due).
    // If Balance is 500, it means I have paid 500 MORE than what was due up to TODAY.
    // So I am paid for 'now' + 2 months.

    final futureDate = DateTime(now.year, now.month + monthsAdvance);

    // Formatting: "Payé jusqu'à MARS 2026"
    final monthName = _getMonthName(futureDate.month);
    return "Payé jusqu'à $monthName ${futureDate.year}";
  }

  String _getMonthName(int month) {
    const months = [
      "JANVIER", "FÉVRIER", "MARS", "AVRIL", "MAI", "JUIN",
      "JUILLET", "AOÛT", "SEPTEMBRE", "OCTOBRE", "NOVEMBRE", "DÉCEMBRE"
    ];
    return months[month - 1];
  }
}
