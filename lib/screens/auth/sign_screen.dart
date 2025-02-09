import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/screens/auth/auth.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';

//ToDo:1. build the page UI take care about theme_done, responsive_done, orientation_done && localization
//ToDo:2. page validation logic_done
//ToDo:3. inject the dateLayer
//ToDo:4. Error Handling
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _passwordController.clear();
      _emailController.clear();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
      // );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    print('ddddddddd');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        iconTheme: IconThemeData(
            size: context.setMinSize(24),
            color: context.textTheme.bodyLarge?.color),
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                end: context.setMinSize(15), top: context.setMinSize(10)),
            child: SizeProvider(
              baseSize: const Size(60, 30),
              width: context.setMinSize(60),
              height: context.setMinSize(60), // scale ( min , min )
              child: Align(
                alignment: Alignment.topRight,
                child: BorderTextButton(
                  text: 'Skip',
                  color: context.colorScheme.primary,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  callback: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.symmetric(
              vertical: context.setWidth(10),
              horizontal: context.setHeight(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                Gap(context.setHeight(70)),

                Image.asset(
                  'assets/main_logo.png',
                  height: context.setMinSize(100),
                ),
                Gap(context.setHeight(20)),
                Text(
                  'Sign in to News Hunt',
                  style: TextStyle(
                    fontSize: context.setSp(18),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.setHeight(20)),
                LoginButton(
                  icon: Image.asset(
                    "assets/google_icon.png",
                    width: context.setMinSize(25),
                    height: context.setMinSize(25),
                  ),
                  text: 'Log in with Google',
                  iconSize: 25,
                  callBack: () async {
                    await Future.delayed(const Duration(seconds: 3));
                  },
                ),
                Gap(context.setHeight(20)),
                LoginButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffef5361),
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
                    await Future.delayed(const Duration(seconds: 3));
                  },
                ),
                Gap(context.setHeight(28)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.setWidth(8)),
                      child: Text(
                        'or',
                        style: TextStyle(
                            color: context.colorScheme.tertiary,
                            fontSize: context.setSp(14)),
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
                Gap(context.setHeight(28)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextFormField(
                        controller: _emailController,
                        label: 'Email',
                        validator: GeneralFunctions.emailValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _passwordController,
                        label: 'Password',
                        isPassword: true,
                        validator: GeneralFunctions.passwordValidator,
                      ),
                      Gap(context.setHeight(18)),
                      RectangleTextButton(
                        callback: _submitForm,
                        color: context.colorScheme.onPrimary,
                        backgroundColor: context.colorScheme.primary,
                        text: 'Log In',
                      ),
                    ],
                  ),
                ),
                Gap(context.setHeight(20)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontSize: context.setSp(14),
                    ),
                  ),
                ),
                Gap(context.setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Account?',
                      style: TextStyle(
                        fontSize: context.setSp(14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountScreen(),
                            ));
                      },
                      child: Text(
                        'Create one',
                        style: TextStyle(
                          color: context.colorScheme.primary,
                          fontSize: context.setSp(14),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(context.setHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
