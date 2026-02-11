import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

class SlideSosButton extends StatefulWidget {
  final VoidCallback onConfirm;

  const SlideSosButton({super.key, required this.onConfirm});

  @override
  State<SlideSosButton> createState() => _SlideSosButtonState();
}

class _SlideSosButtonState extends State<SlideSosButton> {
  double _dragValue = 0.0;
  final double _width = 300.0;
  final double _height = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: AppTheme.errorRed.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.errorRed.withOpacity(0.5)),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              "GLISSER POUR SOS",
              style: TextStyle(
                color: AppTheme.errorRed,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Positioned(
            left: _dragValue,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragValue += details.delta.dx;
                  if (_dragValue < 0) _dragValue = 0;
                  if (_dragValue > _width - _height) _dragValue = _width - _height;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragValue > (_width - _height) * 0.8) {
                  widget.onConfirm();
                  setState(() => _dragValue = _width - _height);
                } else {
                  setState(() => _dragValue = 0);
                }
              },
              child: Container(
                width: _height,
                height: _height,
                decoration: const BoxDecoration(
                  color: AppTheme.errorRed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
