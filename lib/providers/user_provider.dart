import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

/*
 the reason why i did not user auto dispose in StreamNotifierProvider because
 the streams will restart and old streams will be closed whenever a new stream
 is created, and this behavior happens due to how Riverpod's StreamNotifierProvider works
 */

class AuthStateNotifier extends StreamNotifier<User?> {
  @override
  Stream<User?> build() {
    return FirebaseService().authStateChanges();
  }
}

final authStateNotifierProvider =
    StreamNotifierProvider<AuthStateNotifier, User?>(() {
  return AuthStateNotifier();
});

class UserNotifier extends StreamNotifier<UserModel?> {
  @override
  Stream<UserModel?> build() {
    final authState = ref.watch(authStateNotifierProvider).value;

    // If no user is authenticated, return null
    if (authState == null) {
      return Stream.value(null);
    }

    final userRepoProv = ref.read(userRepositoryProvider);
    return userRepoProv.getUserStream(authState.uid);
  }
}

final userNotifierProvider =
    StreamNotifierProvider<UserNotifier, UserModel?>(() {
  return UserNotifier();
});
