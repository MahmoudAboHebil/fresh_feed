import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/screens/screens.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
