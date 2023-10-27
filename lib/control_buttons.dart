// lib/control_buttons.dart
import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.noTimeLeft,
    required this.isPlaying,
    required this.stopTimer,
    required this.startTimer,
    required this.resetTimer,
  });

  final bool noTimeLeft;
  final bool isPlaying;
  final VoidCallback stopTimer;
  final VoidCallback startTimer;
  final VoidCallback resetTimer;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            onPressed: noTimeLeft ? null : (isPlaying ? stopTimer : startTimer),
            icon: isPlaying
                ? const Icon(
                    Icons.pause,
                    size: 50,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(
            width: 100,
          ),
          IconButton(
            onPressed: isPlaying ? null : resetTimer,
            icon: Icon(
              Icons.autorenew,
              size: 50,
              color: isPlaying ? Colors.grey : Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
