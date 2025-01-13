import 'package:flutter/material.dart';
import 'package:fresh_feed/screens/home_screen.dart';

class FreshFeedApp extends StatelessWidget {
  const FreshFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
