import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class ApartmentGrid extends StatelessWidget {
  const ApartmentGrid({super.key});

  // Optimized Decorations: Pre-calculated to avoid object allocation during build.
  // Paid (Cyan: 0xFF00E5FF)
  static const _paidDecoration = BoxDecoration(
    color: AppTheme.darkNavy,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0xCC00E5FF), width: 1.5), // 0.8 opacity
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0x3300E5FF), // 0.2 opacity
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Debt (Red: 0xFFFF0040)
  static const _debtDecoration = BoxDecoration(
    color: AppTheme.darkNavy,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0xCCFF0040), width: 1.5), // 0.8 opacity
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0x33FF0040), // 0.2 opacity
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

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
                  decoration: isDebt ? _debtDecoration : _paidDecoration,
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
