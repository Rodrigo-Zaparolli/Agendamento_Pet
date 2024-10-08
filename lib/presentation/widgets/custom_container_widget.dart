import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  const CustomContainerWidget(
      {super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: color,
      child: child,
    );
  }
}
