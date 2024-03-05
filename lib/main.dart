import 'package:flutter/material.dart';
import 'package:newcam/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}