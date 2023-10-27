import 'package:custom_widget/countdown_timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countdown Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const CountdownTimer(),
    );
  }
}
