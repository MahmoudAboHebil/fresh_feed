import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});
  static BookmarksScreen builder(
          BuildContext buildContext, GoRouterState state) =>
      BookmarksScreen();
  @override
  ConsumerState<BookmarksScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bookmarks Screen',
        )
      ],
    );
  }
}
