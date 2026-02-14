import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class LuxuryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const LuxuryCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppTheme.darkNavy,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppTheme.gold.withOpacity(0.3), width: 1),
        ),
        child: Semantics(
          button: onTap != null,
          enabled: onTap != null,
          child: InkWell(
            onTap: onTap,
            splashColor: AppTheme.gold.withOpacity(0.1),
            highlightColor: AppTheme.gold.withOpacity(0.05),
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}
