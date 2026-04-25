import 'package:flutter/material.dart';
import 'package:last/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Syria Car Care',
      theme: ThemeData(
        primaryColor: const Color(0xFF102A43),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF102A43)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
