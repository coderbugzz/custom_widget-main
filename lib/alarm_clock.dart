import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlarmClock extends StatelessWidget {
  const AlarmClock({
    super.key,
    required this.onReset,
  });

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset('assets/alarm.json'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Time\'s up!!!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          IconButton(
            onPressed: onReset,
            icon: const Icon(
              Icons.autorenew,
              size: 50,
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
