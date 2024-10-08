import 'package:flutter/material.dart';

class CustomButtomWidget extends StatelessWidget {
  final Widget buttonChild;
  final VoidCallback onPressed;
  final Color color;

  const CustomButtomWidget({
    super.key,
    required this.buttonChild,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: RawMaterialButton(
        elevation: 0.0,
        hoverElevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        fillColor: color,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: buttonChild,
      ),
    );
  }
}
