// lib/countdown_timer.dart
import 'dart:async';

import 'package:custom_widget/alarm_clock.dart';
import 'package:custom_widget/circular_clock.dart';
import 'package:custom_widget/digital_clock.dart';
import 'package:custom_widget/control_buttons.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  // the timer that will be used to control the countdown timer
  late Timer _timer;

  // bool value to check if the countdown timer is counting down or not
  bool _isPlaying = false;

  // keep track of how much time has elapsed while the widget is counting down (i.e. timer is running)
  int _timeElapsed = 0;

  // variable to store the time to countdown based on user selection
  Duration _totalTime = const Duration(milliseconds: 0);

  // some constant that will be used by the timer to determine how often the state gets updated
  final Duration _periodicMovement = const Duration(milliseconds: 1000);

  // function to handle countdown
  void _countdown(Timer timer) {
    //
    setState(() {
      if (_timeElapsed <= _totalTime.inMilliseconds) {
        _timeElapsed += _periodicMovement.inMilliseconds;
      } else {
        _timer.cancel();
      }
    });
  }

  // function to start timer
  void _startTimer() {
    setState(() {
      _isPlaying = true;
    });
    _timer = Timer.periodic(
      _periodicMovement,
      _countdown,
    );
  }

  // function to stop timer
  void _stopTimer() {
    setState(() {
      _isPlaying = false;
    });
    _timer.cancel();
  }

  // function to reset timer
  void _resetTimer() {
    setState(() {
      _isPlaying = false;
      _timeElapsed = 0;
      _totalTime = const Duration(seconds: 0);
    });
  }

  // dispose of timer and controllers to prevent memory leak
  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _totalTime.inMilliseconds == 0
        ? 1
        : 1 - (_timeElapsed / _totalTime.inMilliseconds);

    int timeLeft = _totalTime.inMilliseconds - _timeElapsed;

    bool noTimeLeft = timeLeft <= 0;

    return Scaffold(
      backgroundColor: Colors.black,
      // if the timeElapsed exceeds the total time, show the alarm animation
      // else show the countdown
      body: _timeElapsed > _totalTime.inMilliseconds
          ? AlarmClock(
              onReset: _resetTimer,
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                const Positioned(
                  top: 0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tap timer to get started',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // starts at 1 so right hand should be zero
                      // remaining time
                      CircularClock(progress: progress),
                      DigitalClock(
                        timeLeft: timeLeft,
                        totalTime: _totalTime,
                        onUpdateMinutes: (int value) {
                          setState(() {
                            _totalTime = Duration(
                              minutes: value,
                              seconds: _totalTime.inSeconds % 60,
                            );
                          });
                        },
                        onUpdateSeconds: (int value) {
                          setState(() {
                            _totalTime = Duration(
                              minutes: _totalTime.inMinutes,
                              seconds: value,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ControlButtons(
                  noTimeLeft: noTimeLeft,
                  isPlaying: _isPlaying,
                  stopTimer: _stopTimer,
                  startTimer: _startTimer,
                  resetTimer: _resetTimer,
                ),
              ],
            ),
    );
  }
}
