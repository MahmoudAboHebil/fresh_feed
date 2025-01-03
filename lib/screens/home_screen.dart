import 'package:flutter/material.dart';
import 'package:fresh_feed/screens/sign_in_up.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: Text('go Sign'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInUp(),
                ));
          },
        ),
      ),
    );
  }
}
