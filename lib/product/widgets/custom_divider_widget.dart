import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({required this.color, super.key});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
    );
  }
}
