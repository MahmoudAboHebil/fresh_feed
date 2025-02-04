import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';

//ToDo:1. build the page UI take care about thieme,localization, responsive && orientation
//ToDo:2. inject the dateLayer
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  @override
  Widget build(BuildContext context) {
    print(context.setWidth(1));
    print(context.setHeight(1));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.symmetric(
                vertical: context.setMinSize(10),
                horizontal: context.setMinSize(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizeProvider(
                  baseSize: const Size(60, 30),
                  width: context.setMinSize(60),
                  height: context.setMinSize(60), // scale ( min , min )
                  child: Align(
                    alignment: Alignment.topRight,
                    child: BorderTextButton(
                      text: 'Skip',
                      color: context.colorScheme.primary,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      callback: () {
                        print(MediaQuery.of(context).size);
                        print('context.screenWidth  ${context.screenWidth}');
                        print('context.screenHeight  ${context.screenHeight}');
                        print('width scale  ${context.setWidth(1)}');
                        print('height scale  ${context.setHeight(1)}');

                        print('press');
                      },
                    ),
                  ),
                ),
                // logo
                Gap(context.setHeightScreenBase(0.1)),
                Container(
                  width: context.setWidth(230),
                  height: context.setWidth(160),
                  color: Colors.grey,
                ),
                Gap(context.setHeightScreenBase(0.02)),
                Text(
                  'Sign in to News Hunt',
                  style: TextStyle(
                    fontSize: context.setSp(18),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.setHeightScreenBase(0.02)),
                LoginButton(
                  icon: Image.asset(
                    "assets/google_icon.png",
                    width: context.setMinSize(25),
                    height: context.setMinSize(25),
                  ),
                  text: 'Log in with Google',
                  iconSize: 25,
                  callBack: () async {
                    await Future.delayed(Duration(seconds: 3));
                  },
                ),
                Gap(context.setHeightScreenBase(0.02)),
                LoginButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffef5361),
                        borderRadius: BorderRadius.circular(50)),
                    width: context.setMinSize(25),
                    height: context.setMinSize(25),
                    child: Icon(
                      Icons.local_phone_sharp,
                      color: Colors.white,
                      size: context.setMinSize(19),
                    ),
                  ),
                  text: 'Log in with Number',
                  iconSize: 25,
                  callBack: () async {
                    await Future.delayed(Duration(seconds: 3));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
