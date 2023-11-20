import 'dart:math' show pi;

import 'package:flutter/material.dart';

import 'curves_clippers.dart';
import 'tween_tranform.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CurvesClippers(),
    );
  }
}
