import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dicee',
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDice = 1;
  int rightDice = 1;
  final Random _random = Random();

  void rollDice() {
    setState(() {
      leftDice = _random.nextInt(6) + 1;
      rightDice = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Dicee'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: rollDice,
                  child: Image.asset('assets/images/dice$leftDice.png'),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: rollDice,
                  child: Image.asset('assets/images/dice$rightDice.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
