import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
