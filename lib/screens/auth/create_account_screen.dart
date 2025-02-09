import 'package:flutter/material.dart';
import 'package:fresh_feed/screens/auth/sign_screen.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:gap/gap.dart';

import '../../widgets/login_text_form_field.dart';
import '../../widgets/rectangle_text_button.dart';

//ToDo:1. build the page UI take care about theme_done, responsive_done, orientation_done && localization
//ToDo:2. page validation logic_done
//ToDo:3. inject the dateLayer
//ToDo:4. Error Handling

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _rePasswordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _passwordController.clear();
      _emailController.clear();
      _nameController.clear();
      _rePasswordController.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
            size: context.setMinSize(24),
            color: context.textTheme.bodyLarge?.color),
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
                Gap(context.setHeight(70)),
                Container(
                  child: Image.asset(
                    'assets/main_logo.png',
                    height: context.setMinSize(100),
                  ),
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
                        controller: _nameController,
                        label: 'Name',
                        validator: GeneralFunctions.nameValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _passwordController,
                        label: 'Password',
                        isPassword: true,
                        validator: GeneralFunctions.passwordValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _rePasswordController,
                        label: 'Re-enter Password',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Re-Password is required';
                          } else if (value != _passwordController.text) {
                            return 'Re-Password doesn\'t match';
                          }
                          return null;
                        },
                      ),
                      Gap(context.setHeight(18)),
                      RectangleTextButton(
                        callback: _submitForm,
                        color: context.colorScheme.onPrimary,
                        backgroundColor: context.colorScheme.primary,
                        text: 'Create Account',
                      ),
                    ],
                  ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account? ',
                      style: TextStyle(
                        fontSize: context.setSp(14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignScreen(),
                            ));
                      },
                      child: Text(
                        'Sign in',
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
