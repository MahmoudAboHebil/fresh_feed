import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/loading_components/loading_components.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/custom_text_form_field.dart';
import 'package:fresh_feed/widgets/no_network_widget.dart';
import 'package:fresh_feed/widgets/no_user_widget.dart';
import 'package:fresh_feed/widgets/phone_text_field.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../config/route/route_name.dart';
import '../generated/l10n.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/rectangle_text_button.dart';
//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//(done): Error Handling net&userError_done
//progress==>
//TODO: Phone Text Filed
//TODO: Pick Image process
//TODO: localization
//TODO: page validation logic submit
//TODO: inject the dateLayer
//TODO: Image Chasing

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});
  static UserScreen builder(BuildContext buildContext, GoRouterState state) =>
      UserScreen();

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  PhoneNumber? userPhone;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        print('phone: $userPhone');
      }
    } catch (e) {
      AppAlerts.displaySnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final generalFuncs = GeneralFunctions(context);

    final networkStream = ref.watch(networkInfoStreamNotifierProv);
    final userStream = ref.watch(userNotifierProvider);

    return networkStream.when(
      data: (isConnect) {
        if (isConnect) {
          // network is ok
          return userStream.when(
            data: (user) {
              if (user == null) {
                // there is no user
                return Scaffold(
                  body: NoUserWidget(),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: true,
                      centerTitle: false,
                      iconTheme: IconThemeData(
                        color: context.textTheme.bodyLarge?.color,
                      ),
                      backgroundColor: Colors.transparent,
                      toolbarHeight: context.setMinSize(50),
                      scrolledUnderElevation: 0,
                      title: Text(
                        user.name,
                        style: TextStyle(
                            fontSize: context.setSp(23),
                            color: context.textTheme.bodyLarge?.color),
                      ),
                    ),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsetsDirectional.symmetric(
                            vertical: context.setWidth(15),
                            horizontal: context.setHeight(15),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Gap(context.setHeight(110)),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: context
                                                  .colorScheme.secondary)),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: context.setMinSize(60),
                                        backgroundImage: NetworkImage(
                                          user.profileImageUrl!,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('hello');
                                      },
                                      child: Container(
                                        height: context.setMinSize(38),
                                        width: context.setMinSize(38),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color:
                                                  context.colorScheme.primary),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            color: context.colorScheme.primary,
                                            size: context.setMinSize(19),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Gap(context.setHeight(30)),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                        controller: _nameController,
                                        initialValue: user.name,
                                        label: S.of(context).name,
                                        prefixIcon: Icons.person,
                                        enable: true,
                                        validator: generalFuncs.nameValidator,
                                      ),
                                      Gap(context.setHeight(25)),
                                      CustomTextFormField(
                                        controller: _emailController,
                                        initialValue: user.email ?? '',
                                        label: S.of(context).email,
                                        prefixIcon: Icons.email,
                                        enable: false,
                                      ),
                                      Gap(context.setHeight(25)),
                                      PhoneTextField(
                                        controller: _phoneController,
                                        callBack: (value) {
                                          setState(() {
                                            userPhone = value;
                                          });
                                        },
                                      ),
                                      Gap(context.setHeight(70)),
                                      RectangleTextButton(
                                        text: 'Update Profile',
                                        verticalPadding: 11,
                                        fontSize: 15,
                                        color: context.colorScheme.onPrimary,
                                        backgroundColor:
                                            context.colorScheme.primary,
                                        callback: () async {
                                          await _submitForm();
                                        },
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
                    ),
                  ),
                );
              }
            },
            error: (error, stack) {
              // Error user
              return Scaffold(
                body: AppErrorWidget(
                  buttonText: "Back to Home page",
                  callBack: () {
                    context.goNamed(RouteName.home);
                  },
                ),
              );
            },
            loading: () {
              // Loading user
              return const Scaffold(
                body: UserScreenLoading(),
              );
            },
          );
        } else {
          // network is lost
          return const Scaffold(
            body: NoNetworkWidget(),
          );
        }
      },
      error: (error, stack) {
        // error network
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: AppErrorWidget(
              buttonText: null,
              callBack: null,
            ),
          ),
        );
      },
      loading: () {
        // loading network
        return const Scaffold(
          body: UserScreenLoading(),
        );
      },
    );
  }
}
