import 'package:flutter/material.dart';

class CustomErroWidget extends StatelessWidget {
  final String message;

  const CustomErroWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
