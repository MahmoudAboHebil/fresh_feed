import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';

//ToDo:1. build the page UI take care about thieme, responsive && orientation
//ToDo:2. inject the dateLayer
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeProvider(
              baseSize: const Size(60, 30),
              width: context.setMinSize(60),
              height: context.setMinSize(30), // scale ( min , min )
              child: BorderTextButton(
                text: 'Skip',
                color: context.colorScheme.primary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                callback: () {
                  print('press');
                },
              ),
            ),
            Image.asset(
              "assets/logo_2.png",
              height: 300,
              width: 300,
            )
          ],
        ),
      ),
    );
  }
}
