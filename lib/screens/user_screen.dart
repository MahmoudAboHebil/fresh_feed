import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/loading_components/loading_components.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/route/route_name.dart';
import '../generated/l10n.dart';
//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//(done): Error Handling net&userError_done
//progress==>
//TODO: verified email _ need test
//TODO: verified phone
//(done): Phone Text Filed => get from DB
//(done): Pick Image process => no image & display
//TODO: localization
//(done): page validation logic submit
//(done): inject the dateLayer => send to DB
//TODO: Image Chasing

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({required this.user, super.key});
  final UserModel? user;
  static UserScreen builder(BuildContext buildContext, GoRouterState state) {
    final user = state.extra as UserModel?;
    return UserScreen(
      user: user,
    );
  }

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  PhoneNumber? userPhone;
  File? pickUpImage;
  bool sendEmail = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _submitForm(UserModel userModel) async {
    try {
      if (_formKey.currentState!.validate()) {
        final userRepoProv = ref.read(userRepositoryProvider);
        final cloudinaryRepoProv = ref.read(cloudinaryRepoProvider);
        String? imageURL;
        if (pickUpImage != null) {
          imageURL =
              await cloudinaryRepoProv.uploadImage(pickUpImage!, userModel.uid);
        }

        await userRepoProv.saveUserData(
          userModel.copyWith(
              profileImageUrl: imageURL,
              phoneNumber: userPhone?.phoneNumber,
              phoneDialCode: userPhone?.dialCode,
              phoneIsoCode: userPhone?.isoCode,
              name: _nameController.text),
        );
        context.goNamed(RouteName.profile);
      }
    } catch (e) {
      print(e.toString());
      AppAlerts.displaySnackBar(e.toString(), context);
    }
  }

  bool isEnable(UserModel user) {
    bool isPhoneChanged;

    if (_phoneController.text.isEmpty && (user.phoneNumber?.isEmpty ?? true)) {
      isPhoneChanged = false;
    } else {
      isPhoneChanged = (userPhone?.phoneNumber != user.phoneNumber);
    }

    if (pickUpImage != null ||
        isPhoneChanged ||
        _nameController.text != user.name) {
      // not the same
      print(" phone ${userPhone?.phoneNumber != user.phoneNumber}");
      print('vari${userPhone?.phoneNumber}');
      print('user${user.phoneNumber} }');
      print(" image ${pickUpImage != null}");
      print(" name ${_nameController.text != user.name}");
      print(" contr ${_nameController.text}");
      print(" db ${user.name}");
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) async {
      setState(() {
        userPhone = PhoneNumber(
          phoneNumber: widget.user?.phoneNumber,
          isoCode: widget.user?.phoneIsoCode,
          dialCode: widget.user?.phoneDialCode,
        );
      });
      _nameController.text = widget.user?.name ?? '';
      final auth_repo = ref.read(authRepositoryProvider);
      await auth_repo.listenToEmailVerification(widget.user, () {
        AppAlerts.displaySnackBar(S.of(context).EmailVerified, context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth_repo = ref.watch(authRepositoryProvider);

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
                final ImageProvider userImage;
                if (pickUpImage != null) {
                  userImage = FileImage(pickUpImage!);
                } else if (user.profileImageUrl != null) {
                  userImage = NetworkImage(
                    user.profileImageUrl!,
                  );
                } else {
                  userImage = const AssetImage("assets/user_profile.png");
                }
                userPhone ??= PhoneNumber(
                  phoneNumber: widget.user?.phoneNumber,
                  isoCode: widget.user?.phoneIsoCode,
                  dialCode: widget.user?.phoneDialCode,
                );

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
                                        backgroundImage: userImage,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          final isPremOk =
                                              await PermissionHandlerService
                                                  .checkPermissionStatus(
                                            Permission.camera,
                                            "Camera",
                                            context,
                                          );
                                          if (isPremOk) {
                                            final image = await AppAlerts
                                                .showImagePickerOptions(
                                                    context);
                                            if (image != null) {
                                              //ToDo: handling the image
                                              setState(() {
                                                pickUpImage = image;
                                              });
                                            }
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
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
                                        suffixWidget: user.emailVerified
                                            ? Icon(
                                                Icons.verified,
                                                color: Colors.green,
                                                size: context.setMinSize(20),
                                              )
                                            : IconButton(
                                                onPressed: () async {
                                                  if (sendEmail) {
                                                    setState(() {
                                                      sendEmail = false;
                                                    });
                                                    final auth_repo = ref.read(
                                                        authRepositoryProvider);
                                                    await auth_repo
                                                        .sendEmailVerification();
                                                    AppAlerts.displaySnackBar(
                                                        S
                                                            .of(context)
                                                            .SendEmailVerify,
                                                        context);

                                                    if (mounted) {
                                                      await Future.delayed(
                                                        const Duration(
                                                            seconds: 10),
                                                        () {
                                                          setState(() {
                                                            sendEmail = true;
                                                          });
                                                        },
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .mark_email_unread_rounded,
                                                  color:
                                                      context.colorScheme.error,
                                                  size: context.setMinSize(20),
                                                ),
                                              ),
                                        enable: false,
                                      ),
                                      Gap(context.setHeight(25)),
                                      PhoneTextField(
                                        initialPhoneNumber: userPhone,
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
                                        enable: isEnable(user),
                                        color: context.colorScheme.onPrimary,
                                        backgroundColor:
                                            context.colorScheme.primary,
                                        callback: () async {
                                          await _submitForm(user);
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
