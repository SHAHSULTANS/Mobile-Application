import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  final AudioPlayer player = AudioPlayer();
  int? currentNote;

  void playNote(int noteNumber) {
    setState(() {
      currentNote = noteNumber;
    });
    player.play(AssetSource('note$noteNumber.wav'));
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        currentNote = null;
      });
    });
  }

  Expanded buildKey({
    required List<Color> gradientColors,
    required int noteNumber,
    required String noteLabel,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: GestureDetector(
          onTap: () => playNote(noteNumber),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                noteLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Xylophone'),
          backgroundColor: Colors.black87,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // সেটিংস পেজে নেভিগেট করার জন্য
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(
                gradientColors: [Colors.red, Colors.redAccent],
                noteNumber: 1,
                noteLabel: 'C',
              ),
              buildKey(
                gradientColors: [Colors.orange, Colors.orangeAccent],
                noteNumber: 2,
                noteLabel: 'D',
              ),
              buildKey(
                gradientColors: [Colors.yellow, Colors.yellowAccent],
                noteNumber: 3,
                noteLabel: 'E',
              ),
              buildKey(
                gradientColors: [Colors.green, Colors.greenAccent],
                noteNumber: 4,
                noteLabel: 'F',
              ),
              buildKey(
                gradientColors: [Colors.teal, Colors.tealAccent],
                noteNumber: 5,
                noteLabel: 'G',
              ),
              buildKey(
                gradientColors: [Colors.blue, Colors.blueAccent],
                noteNumber: 6,
                noteLabel: 'A',
              ),
              buildKey(
                gradientColors: [Colors.purple, Colors.purpleAccent],
                noteNumber: 7,
                noteLabel: 'B',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
