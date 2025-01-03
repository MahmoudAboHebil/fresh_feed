import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

//user login => save firestore => listen to firestore => get current user

// final authStateProvider = StreamProvider<User?>((ref) {
//   return FirebaseService().authStateChanges();
// });
//
// final userProvider = StreamProvider<UserModel?>((ref) {
//   final authState = ref.watch(authStateProvider);
//   if (authState.value == null) {
//     return Stream.value(null);
//   }
//   final userRepoProv = ref.read(userRepositoryProvider);
//   final userStream = userRepoProv.getUserStream(authState.value!.uid);
//
//   return userStream;
// });

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
