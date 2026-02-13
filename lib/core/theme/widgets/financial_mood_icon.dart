import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class FinancialMoodIcon extends StatelessWidget {
  final double monthsOfSurvival;
  final double size;

  const FinancialMoodIcon({super.key, required this.monthsOfSurvival, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    String semanticLabel;
    IconData icon;
    Color color;

    if (monthsOfSurvival >= 3.0) {
      // GREEN: Happy / Relaxed
      semanticLabel = "Santé financière excellente";
      icon = Icons.sentiment_very_satisfied;
      color = const Color(0xFF00E5FF); // Cyan/Greenish
    } else if (monthsOfSurvival >= 0.0) {
      // ORANGE: Stress / Sweating (Simulated with neutral + color)
      semanticLabel = "Santé financière stable";
      icon = Icons.sentiment_neutral;
      color = const Color(0xFFFFAB00); // Amber/Orange
    } else {
      // RED: Panic / Siren
      semanticLabel = "Santé financière critique";
      icon = Icons.add_alert; // Alert Siren equivalent
      color = AppTheme.errorRed;
    }

    return Tooltip(
      message: semanticLabel,
      child: Semantics(
        label: semanticLabel,
        excludeSemantics: true,
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
