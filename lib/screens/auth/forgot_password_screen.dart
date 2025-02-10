import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:gap/gap.dart';

import '../../generated/l10n.dart';
import '../../widgets/login_text_form_field.dart';
import '../../widgets/rectangle_text_button.dart';

//(done) ToDo:1. build the page UI take care about theme_done, responsive_done, orientation_done && localization_done
//(done) ToDo:2. page validation logic_done

// progress
//ToDo:3. inject the dateLayer
//ToDo:4. Error Handling

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _emailController.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final generalFuncs = GeneralFunctions(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(context.setHeight(30)),
                Text(
                  S.of(context).forgotPasswordWithoutQM,
                  style: TextStyle(
                    fontSize: context.setSp(22),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(context.setHeight(15)),
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(end: context.setWidth(10)),
                  child: Text(
                    S.of(context).forgotPasswordTitle,
                    style: TextStyle(
                      fontSize: context.setSp(16),
                      color: context.colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Gap(context.setHeight(30)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextFormField(
                        controller: _emailController,
                        label: S.of(context).email,
                        validator: generalFuncs.emailValidator,
                      ),
                      Gap(context.setHeight(30)),
                      RectangleTextButton(
                        callback: _submitForm,
                        color: context.colorScheme.onPrimary,
                        backgroundColor: context.colorScheme.primary,
                        text: S.of(context).sendEmail,
                      ),
                    ],
                  ),
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
