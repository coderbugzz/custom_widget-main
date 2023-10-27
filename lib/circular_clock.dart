// lib/circular_clock.dart
import 'package:flutter/material.dart';

class CircularClock extends StatelessWidget {
  const CircularClock({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      height: 225,
      child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation(Colors.white),
        color: Colors.white,
        value: progress,
        strokeWidth: 12,
      ),
    );
  }
}
