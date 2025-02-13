import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';

//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//progress==>
//TODO: localization
//TODO: page validation logic
//TODO: inject the dateLayer
//TODO: Error Handling
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

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
            titleText: 'Log In',
            callBack: () {},
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
          callBack: () {},
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
          titleText: 'Followed Channels',
          callBack: () {},
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
          titleText: 'Bookmarks',
          callBack: () {},
        ),
        Gap(context.setHeight(10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final networkStream = ref.watch(networkInfoStreamNotifierProv);
    final userStream = ref.watch(userNotifierProvider);
    final userBookmarksProv = ref.read(userBookmarksNotifierProvider.notifier);
    final userFollowedChannelsProv =
        ref.read(userFollowedChannelsNotifierProvider.notifier);
    ref.listen(userListenerProvider, (prev, now) async {
      print(
          'userListenerProvider (SignInUp) about user Bookmarks-article=====>');
      try {
        await userBookmarksProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });
    ref.listen(userListenerProvider, (prev, now) async {
      print(
          'userListenerProvider (SignInUp) about user followed-channels=====>');
      try {
        await userFollowedChannelsProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });

    return networkStream.when(
      data: (isConnect) {
        if (isConnect) {
          // network is ok
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                toolbarHeight: context.setMinSize(50),
                scrolledUnderElevation: 0,
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: context.setSp(23),
                      color: context.textTheme.bodyLarge?.color),
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsetsDirectional.symmetric(
                    vertical: context.setWidth(15),
                    horizontal: context.setHeight(15),
                  ),
                  child: userStream.when(
                    data: (user) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(context.setHeight(10)),
                          getTopUserComponents(user),
                          Text(
                            'General Settings',
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
                            titleText: 'Theme',
                            callBack: () {},
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
                            titleText: 'Contact Us',
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
                            titleText: 'Language',
                            callBack: () {},
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
                            titleText: 'Privacy Policy',
                            callBack: () {},
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
                            titleText: 'About Us',
                            callBack: () {},
                          ),
                          Gap(context.setHeight(30)),
                          if (user != null)
                            RectangleTextButton(
                              text: 'Log Out',
                              verticalPadding: 12,
                              fontSize: 15,
                              color: context.colorScheme.onPrimary,
                              backgroundColor: context.colorScheme.primary,
                              callback: () async {
                                await Future.delayed(Duration(seconds: 2));
                              },
                            ),
                        ],
                      );
                    },
                    error: (error, stack) {
                      // Error user
                      return Center(
                        child: Text('Error User'),
                      );
                    },
                    loading: () {
                      // Loading user
                      return CircularProgressIndicator(
                        color: Colors.green,
                      );
                    },
                  ),
                ),
              )));
        } else {
          // network is lost
          return Scaffold();
        }
      },
      error: (error, stack) {
        // error network
        return Scaffold(
          body: Center(
            child: Text('Error network'),
          ),
        );
      },
      loading: () {
        // loading network
        return Scaffold(
          body: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }
}
