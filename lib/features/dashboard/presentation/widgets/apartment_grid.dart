import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class ApartmentGrid extends StatelessWidget {
  const ApartmentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final apartmentNumber = index + 1;
          // Mock Status: Even numbers are debt (Red), Odd are paid (Cyan)
          final bool isDebt = apartmentNumber % 2 == 0;
          final Color borderColor = isDebt ? const Color(0xFFFF0040) : const Color(0xFF00E5FF);
          final String statusText = isDebt ? "Payment Overdue" : "Up to date";
          final String semanticLabel = "Apartment $apartmentNumber, $statusText";

          return Semantics(
            label: semanticLabel,
            hint: "Double tap to view details",
            button: true,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () {
                // Navigation placeholder
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening Apartment $apartmentNumber')),
                );
              },
              child: Tooltip(
                message: semanticLabel,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.darkNavy,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: borderColor.withOpacity(0.8),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: borderColor.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'AP$apartmentNumber',
                      style: const TextStyle(
                        color: AppTheme.offWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: 15,
      ),
    );
  }
}
