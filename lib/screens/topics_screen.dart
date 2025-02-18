import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopicsScreen extends ConsumerStatefulWidget {
  const TopicsScreen({super.key});
  static TopicsScreen builder(BuildContext buildContext, GoRouterState state) =>
      TopicsScreen();
  @override
  ConsumerState<TopicsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<TopicsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Topics Screen',
        )
      ],
    );
  }
}
