import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class LuxuryTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const LuxuryTextField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.autofocus = false,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<LuxuryTextField> createState() => _LuxuryTextFieldState();
}

class _LuxuryTextFieldState extends State<LuxuryTextField> {
  late TextEditingController _internalController;
  late FocusNode _internalFocusNode;
  late bool _isObscured;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    } else {
      _internalController = TextEditingController();
    }
    _internalFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _internalController.dispose();
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _effectiveFocusNode.requestFocus();
          },
          child: Text(
            widget.label.toUpperCase(),
            style: TextStyle(
              color: AppTheme.gold.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _effectiveController,
          builder: (context, value, child) {
            return TextFormField(
              focusNode: _effectiveFocusNode,
              autofocus: widget.autofocus,
              textInputAction: widget.textInputAction,
              onFieldSubmitted: widget.onFieldSubmitted,
              controller: _effectiveController,
              obscureText: _isObscured,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              validator: widget.validator,
              style: const TextStyle(color: AppTheme.offWhite),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: AppTheme.offWhite.withOpacity(0.4)),
                filled: true,
                fillColor: AppTheme.darkNavy.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.gold.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.gold.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.gold, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.errorRed, width: 1),
                ),
                suffixIcon: _buildSuffixIcon(value.text.isNotEmpty),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(bool hasText) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: AppTheme.gold.withOpacity(0.7),
        ),
        tooltip: _isObscured ? 'Afficher le mot de passe' : 'Masquer le mot de passe',
        onPressed: () {
          HapticFeedback.selectionClick();
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    } else if (hasText) {
      return IconButton(
        icon: Icon(
          Icons.close,
          color: AppTheme.gold.withOpacity(0.5),
          size: 20,
        ),
        tooltip: 'Effacer le texte',
        onPressed: () {
          HapticFeedback.mediumImpact();
          _effectiveController.clear();
          widget.onChanged?.call('');
          _effectiveFocusNode.requestFocus();
        },
      );
    }
    return null;
  }
}
