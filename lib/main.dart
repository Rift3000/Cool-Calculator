import 'package:flutter/material.dart';
import 'home-screen.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoolCalculator(),
    );
  }
}
