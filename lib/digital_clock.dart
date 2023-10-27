// lib/digital_clock.dart
import 'package:flutter/material.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({
    super.key,
    required this.timeLeft,
    required this.totalTime,
    required this.onUpdateMinutes,
    required this.onUpdateSeconds,
  });

  final int timeLeft;
  final Duration totalTime;

  final Function(int value) onUpdateMinutes;
  final Function(int value) onUpdateSeconds;

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  // controllers for bottom sheet
  final FixedExtentScrollController _minutesController =
      FixedExtentScrollController();
  final FixedExtentScrollController _secondsController =
      FixedExtentScrollController();

  @override
  void dispose() {
    _minutesController.dispose();
    _secondsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int seconds = (widget.timeLeft / 1000).floor();
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: ListWheelScrollView(
                      controller: _minutesController,
                      itemExtent: 50,
                      diameterRatio: 1.5,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: widget.onUpdateMinutes,
                      children: List.generate(60, (index) {
                        return Text(
                          "${index.toString().padLeft(2, '0')} minutes",
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        );
                      }),
                    ),
                  );
                });
          },
          child: Text(
            minutes.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontFamily: 'Digi',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontFamily: 'Digi',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 60,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: ListWheelScrollView(
                      controller: _minutesController,
                      itemExtent: 50,
                      diameterRatio: 1.5,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: widget.onUpdateSeconds,
                      children: List.generate(60, (index) {
                        return Text(
                          "${index.toString().padLeft(2, '0')} seconds",
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        );
                      }),
                    ),
                  );
                });
          },
          child: Text(
            remainingSeconds.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontFamily: 'Digi',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
          ),
        ),
      ],
    );
  }
}
