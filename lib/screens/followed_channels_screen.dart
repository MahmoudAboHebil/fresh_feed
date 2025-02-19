import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:go_router/go_router.dart';

//ToDO: this page not in the shell so you need add manually the logic
class FollowedChannelsScreen extends ConsumerStatefulWidget {
  const FollowedChannelsScreen({super.key});
  static FollowedChannelsScreen builder(
          BuildContext buildContext, GoRouterState state) =>
      FollowedChannelsScreen();
  @override
  ConsumerState<FollowedChannelsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<FollowedChannelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: context.textTheme.bodyLarge?.color,
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Followed Channels Screen',
          )
        ],
      ),
    );
  }
}
