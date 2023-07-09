import 'package:flutter/material.dart';
import 'package:speech/screens/speech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Speech(),
    );
  }
}
