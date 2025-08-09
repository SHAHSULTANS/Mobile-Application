import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dicee',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      themeMode: ThemeMode.system, // Supports system theme (light/dark)
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  final Random _random = Random();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for dice roll effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void rollDice() {
    HapticFeedback.lightImpact(); // Haptic feedback on roll
    setState(() {
      leftDice = _random.nextInt(6) + 1;
      rightDice = _random.nextInt(6) + 1;
    });
    _animationController.forward(from: 0); // Trigger animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).brightness == Brightness.light
                  ? Colors.blue[100]!
                  : Colors.blueGrey[900]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dicee',
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.blue[800]
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDice(leftDice),
                  const SizedBox(width: 20),
                  _buildDice(rightDice),
                ],
              ),
              const SizedBox(height: 40),
              FloatingActionButton.large(
                onPressed: rollDice,
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.casino, size: 40, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
                highlightElevation: 12,
              ),
              const SizedBox(height: 20),
              Text(
                'Tap to Roll',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[600]
                      : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDice(int diceNumber) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_animation.value * 0.1), // Slight scale animation
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.black.withOpacity(0.3),
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white.withOpacity(0.8)
                          : Colors.grey[900]!.withOpacity(0.8),
                      offset: const Offset(-5, -5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/dice$diceNumber.png',
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          'Image not found',
                          style: GoogleFonts.poppins(color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}