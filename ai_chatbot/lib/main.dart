import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // flutterfire configure দ্বারা তৈরি
import 'core/app_theme.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  // Flutter bindings নিশ্চিত করা
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialize করা
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}