import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(value, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}
