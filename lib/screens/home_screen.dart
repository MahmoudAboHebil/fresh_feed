import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/route/route_name.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(BuildContext buildContext, GoRouterState state) =>
      HomeScreen();
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Home Screen'),
        MaterialButton(
          color: Colors.red,
          child: const Text('Go followed Channels'),
          onPressed: () async {
            context.pushNamed(RouteName.followedChannels);
          },
        )
      ],
    );
  }
}
