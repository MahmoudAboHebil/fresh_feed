import 'package:firebase_auth/firebase_auth.dart';
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
//TODO: Image Chasing

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});
  static CreateAccountScreen builder(
          BuildContext buildContext, GoRouterState state) =>
      CreateAccountScreen();

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _rePasswordController = TextEditingController();

  Future<void> _submitForm() async {
    try {
      bool isConnected = ref.read(networkInfoStreamNotifierProv).value ?? false;
      print(isConnected);
      final authRepo = ref.read(authRepositoryProvider);
      final userBookmarksProv =
          ref.read(userBookmarksNotifierProvider.notifier);
      final userFollowedChannelsProv =
          ref.read(userFollowedChannelsNotifierProvider.notifier);

      if (_formKey.currentState!.validate()) {
        // check connections
        if (!isConnected) {
          AppAlerts.displaySnackBar(S.of(context).noInternet, context);
          return;
        }

        // create account
        User? user;
        try {
          user = await authRepo.signUp(
              email: _emailController.text.toLowerCase(),
              password: _passwordController.text,
              userName: _nameController.text,
              context: context);
        } catch (e) {
          AppAlerts.displaySnackBar(e.toString(), context);
          return;
        }

        // mange user services
        try {
          await userFollowedChannelsProv.loadDataIfStateIsNull(user.uid);
          await userBookmarksProv.loadDataIfStateIsNull(user.uid);
        } catch (e) {
          AppAlerts.displaySnackBar(e.toString(), context);
        }
        _passwordController.clear();
        _emailController.clear();
        _nameController.clear();
        _rePasswordController.clear();
        context.goNamed(RouteName.home);
      }
    } catch (e) {
      AppAlerts.displaySnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final network_steam = ref.watch(networkInfoStreamNotifierProv);
    final generalFuncs = GeneralFunctions(context);

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
                  S.of(context).signTitle,
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
                        label: S.of(context).email,
                        validator: generalFuncs.emailValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _nameController,
                        label: S.of(context).name,
                        validator: generalFuncs.nameValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _passwordController,
                        label: S.of(context).password,
                        isPassword: true,
                        validator: generalFuncs.passwordValidator,
                      ),
                      Gap(context.setHeight(15)),
                      LoginTextFormField(
                        controller: _rePasswordController,
                        label: S.of(context).rePassword,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).rePasswordIsRequired;
                          } else if (value != _passwordController.text) {
                            return S.of(context).rePasswordDoesNotMatch;
                          }
                          return null;
                        },
                      ),
                      Gap(context.setHeight(18)),
                      RectangleTextButton(
                        callback: _submitForm,
                        color: context.colorScheme.onPrimary,
                        backgroundColor: context.colorScheme.primary,
                        text: S.of(context).createAccount,
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
                        S.of(context).or,
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
                      S.of(context).alreadyHaveAccount,
                      style: TextStyle(
                        fontSize: context.setSp(14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(RouteName.signIn);
                      },
                      child: Text(
                        S.of(context).signIn,
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
