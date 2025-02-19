import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});
  static DiscoverScreen builder(
          BuildContext buildContext, GoRouterState state) =>
      DiscoverScreen();
  @override
  ConsumerState<DiscoverScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Discover Screen',
        )
      ],
    );
  }
}
