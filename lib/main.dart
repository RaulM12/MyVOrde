import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyVOrderApp());
}

class MyVOrderApp extends StatelessWidget {
  const MyVOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyVOrder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}