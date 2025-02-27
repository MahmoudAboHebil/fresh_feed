import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/loading_components/loading_components.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../config/route/route_name.dart';
import '../../generated/l10n.dart';

//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//progress==>
//(Done): Language & Theme Buttons
//(Done): Login  & Log Out
//(done): localization
//(done): User & Followed Channels &   Bookmarks Buttons
//(done): inject the dateLayer (User & network)
//(done): page validation logic (Language & Theme Logic)
//(done): Error Handling (Language & Theme Errors_done)&(UserError & Loading)

//(done): Privacy Policy & About Us  Buttons
//TODO: Contact  Buttons
//TODO: Image Chasing
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  static ProfileScreen builder(
          BuildContext buildContext, GoRouterState state) =>
      ProfileScreen();

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Widget getTopUserComponents(UserModel? user) {
    if (user == null) {
      return Column(
        children: [
          CustomListTile(
            leadingChild: Container(
              height: context.setMinSize(32),
              width: context.setMinSize(32),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: context.setMinSize(15),
              ),
            ),
            titleText: S.of(context).login,
            callBack: () {
              context.goNamed(RouteName.signIn);
            },
          ),
          Gap(context.setHeight(18)),
        ],
      );
    }

    return Column(
      children: [
        // user profile tile
        CustomListTile(
          leadingChild: user.profileImageUrl != null
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: context.setMinSize(25),
                  backgroundImage: NetworkImage(
                    user.profileImageUrl!,
                  ),
                )
              : Container(
                  height: context.setMinSize(32),
                  width: context.setMinSize(32),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: context.setMinSize(15),
                  ),
                ),
          titleText: user.name,
          callBack: () {
            context.pushNamed(RouteName.user, extra: user);
          },
        ),
        Gap(context.setHeight(15)),
        // user profile tile
        CustomListTile(
          leadingChild: Container(
            height: context.setMinSize(32),
            width: context.setMinSize(32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              FontAwesomeIcons.blog,
              color: Colors.white,
              size: context.setMinSize(15),
            ),
          ),
          titleText: S.of(context).FollowedChannels,
          callBack: () {
            context.pushNamed(RouteName.followedChannels);
          },
        ),
        Gap(context.setHeight(18)),
      ],
    );
  }

  Widget getUserBookmarks(UserModel? user) {
    if (user == null) return const SizedBox();

    return Column(
      children: [
        CustomListTile(
          leadingChild: Container(
            height: context.setMinSize(32),
            width: context.setMinSize(32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff9e9e9e),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              FontAwesomeIcons.bookmark,
              color: Colors.white,
              size: context.setMinSize(15),
            ),
          ),
          titleText: S.of(context).Bookmarks,
          callBack: () {
            context.goNamed(RouteName.bookmarks);
          },
        ),
        Gap(context.setHeight(10)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) async {
      try {
        final auth_repo = ref.read(authRepositoryProvider);
        final user = await ref.read(authStateNotifierProvider.future);
        await auth_repo.listenToEmailVerification(
          userAsAuth: user,
          successUpdateAlert: () {
            AppAlerts.displaySnackBar(S.of(context).EmailVerified, context,
                backgroundColor: Colors.green);
          },
        );
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(userNotifierProvider);
    final auth_repo = ref.watch(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).Profile,
          style: TextStyle(
              fontSize: context.setSp(23),
              color: context.textTheme.bodyLarge?.color),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsetsDirectional.symmetric(
            vertical: context.setWidth(15),
            horizontal: context.setHeight(15),
          ),
          child: userStream.when(
            data: (user) {
              final auth_repo = ref.watch(authRepositoryProvider);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(context.setHeight(10)),
                  getTopUserComponents(user),
                  Text(
                    S.of(context).GeneralSettings,
                    style: TextStyle(fontSize: context.setSp(20)),
                  ),
                  Gap(context.setHeight(25)),
                  getUserBookmarks(user),
                  // theme
                  CustomListTile(
                    leadingChild: Container(
                      height: context.setMinSize(32),
                      width: context.setMinSize(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.lightbulb,
                        color: Colors.white,
                        size: context.setMinSize(16),
                      ),
                    ),
                    titleText: S.of(context).Theme,
                    callBack: () {
                      final themeProv = ref.read(themeProvider.notifier);
                      AppAlerts.displayThemeModeDialog(context,
                          ref.read(themeProvider).value ?? ThemeMode.system,
                          (theme) async {
                        try {
                          await themeProv.toggleTheme(theme);
                        } catch (e) {
                          AppAlerts.displaySnackBar(e.toString(), context);
                        }
                      });
                    },
                  ),
                  Gap(context.setHeight(10)),

                  // Contact
                  CustomListTile(
                    leadingChild: Container(
                      height: context.setMinSize(32),
                      width: context.setMinSize(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xff41c4fc),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.white,
                        size: context.setMinSize(16),
                      ),
                    ),
                    titleText: S.of(context).ContactUs,
                    callBack: () {},
                  ),
                  Gap(context.setHeight(10)),
                  // language
                  CustomListTile(
                    leadingChild: Container(
                      height: context.setMinSize(32),
                      width: context.setMinSize(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xfffc554d),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.earthAfrica,
                        color: Colors.white,
                        size: context.setMinSize(16),
                      ),
                    ),
                    titleText: S.of(context).Language,
                    callBack: () {
                      final languageProv = ref.read(languageProvider.notifier);
                      AppAlerts.displayLanguageDialog(context,
                          ref.read(languageProvider).value ?? Language.en,
                          (lan) async {
                        try {
                          await languageProv.toggleLanguage(lan);
                        } catch (e) {
                          AppAlerts.displaySnackBar(e.toString(), context);
                        }
                      });
                    },
                  ),
                  Gap(context.setHeight(10)),
                  // Privacy Policy
                  CustomListTile(
                    leadingChild: Container(
                      height: context.setMinSize(32),
                      width: context.setMinSize(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xfff44238),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Colors.white,
                        size: context.setMinSize(16),
                      ),
                    ),
                    titleText: S.of(context).PrivacyPolicy,
                    callBack: () {
                      context.pushNamed(RouteName.privacyPolicy,
                          queryParameters: {
                            'title': S.of(context).PrivacyPolicy
                          });
                    },
                  ),
                  Gap(context.setHeight(10)),
                  // About Us
                  CustomListTile(
                    leadingChild: Container(
                      height: context.setMinSize(32),
                      width: context.setMinSize(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xff4fae50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.white,
                        size: context.setMinSize(16),
                      ),
                    ),
                    titleText: S.of(context).AboutUs,
                    callBack: () {
                      context.pushNamed(RouteName.aboutUS,
                          queryParameters: {'title': S.of(context).AboutUs});
                    },
                  ),
                  Gap(context.setHeight(30)),
                  if (user != null)
                    RectangleTextButton(
                      text: S.of(context).LogOut,
                      verticalPadding: 12,
                      fontSize: 15,
                      color: context.colorScheme.onPrimary,
                      backgroundColor: context.colorScheme.primary,
                      callback: () async {
                        context.goNamed(RouteName.signIn);

                        await Future.delayed(Duration.zero, () async {
                          try {
                            await ref.read(authRepositoryProvider).signOut();

                            try {
                              final userBookmarksProv = ref
                                  .read(userBookmarksNotifierProvider.notifier);
                              final userFollowedChannelsProv = ref.read(
                                  userFollowedChannelsNotifierProvider
                                      .notifier);
                              await userBookmarksProv
                                  .loadDataIfStateIsNull(null);
                              await userFollowedChannelsProv
                                  .loadDataIfStateIsNull(null);
                            } catch (e) {
                              print(e);
                            }
                          } catch (e) {
                            AppAlerts.displaySnackBar(e.toString(), context);
                          }
                        });
                      },
                    ),
                ],
              );
            },
            error: (error, stack) {
              // Error user
              return AppErrorWidget(
                buttonText: "Back to Home page",
                callBack: () {
                  context.goNamed(RouteName.home);
                },
              );
            },
            loading: () {
              // Loading user
              return const ProfileLoading();
            },
          ),
        ),
      ),
    );
  }
}
