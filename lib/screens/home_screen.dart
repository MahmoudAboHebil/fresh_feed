import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/screens/screens.dart';
import 'package:gap/gap.dart';

import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.yellow,
              child: const Text('Go to Profile Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            ),
            Gap(30),
            BottomNavBar()
          ],
        ),
      ),
    );
  }
}
