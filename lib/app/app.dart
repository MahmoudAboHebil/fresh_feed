import 'package:flutter/material.dart';
import 'package:fresh_feed/screens/sign_in_up.dart';

class FreshFeedApp extends StatelessWidget {
  const FreshFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignInUp(),
    );
  }
}
