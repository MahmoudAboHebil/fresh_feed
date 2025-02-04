import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';

//ToDo:1. build the page UI take care about theme, responsive, orientation && localization
//ToDo:2. inject the dateLayer
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hasError = false;

  String? _emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? _passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        hasError = false;
      });
      _passwordController.clear();
      _emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
      );
    } else {
      setState(() {
        hasError = true;
      });
    }
  }

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
                Gap(context.setHeightScreenBase(0.08)),
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
                Gap(context.setHeightScreenBase(0.015)),
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
                ),
                Gap(context.setHeightScreenBase(0.03)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: context.colorScheme.tertiary,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Gap(context.setHeightScreenBase(0.03)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextFormField(
                        controller: _emailController,
                        hasError: hasError,
                        label: 'Email',
                        validator: _emailValidator,
                      ),
                      Gap(context.setHeightScreenBase(0.02)),
                      LoginTextFormField(
                        controller: _passwordController,
                        hasError: hasError,
                        label: 'Password',
                        isPassword: true,
                        validator: _passwordValidator,
                      ),
                      Gap(context.setHeightScreenBase(0.02)),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('تسجيل الدخول'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
