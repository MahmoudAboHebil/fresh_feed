import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../config/route/route_name.dart';
import '../../generated/l10n.dart';

//(done)  build the page UI take care about theme_done, responsive_done, orientation_done && localization_done
//(done)  page validation logic_done
//progress==>
//(done) inject the dateLayer
//(done) Error Handling_done

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        bool isConnected =
            ref.read(networkInfoStreamNotifierProv).value ?? false;
        final authRepo = ref.read(authRepositoryProvider);

        // check connections
        if (!isConnected) {
          AppAlerts.displaySnackBar(S.of(context).noInternet, context);
          return;
        }
        // send Email
        try {
          await authRepo.resetPassword(
              _emailController.text.toLowerCase(), context);
        } catch (e) {
          AppAlerts.displaySnackBar(e.toString(), context);
          return;
        }

        AppAlerts.displaySnackBar(S.of(context).resetPasswordSuccess, context);

        _emailController.clear();

        context.goNamed(RouteName.signIn);
      } else {}
    } catch (e) {
      AppAlerts.displaySnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final generalFuncs = GeneralFunctions(context);
    final network_steam = ref.watch(networkInfoStreamNotifierProv);

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
