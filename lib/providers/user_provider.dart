import 'dart:async';

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
    print('======================>');
    print(authState);

    final userRepoProv = ref.read(userRepositoryProvider);
    return userRepoProv.getUserStream(authState.uid);
  }
}

final userNotifierProvider =
    StreamNotifierProvider<UserNotifier, UserModel?>(() {
  return UserNotifier();
});

class UserListenerNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    final userAsync = ref.watch(userNotifierProvider);

    return userAsync.when<UserModel?>(
      data: (data) => data,
      loading: () => null,
      error: (error, stackTrace) => null,
    );
  }
}

final userListenerProvider =
    NotifierProvider<UserListenerNotifier, UserModel?>(() {
  return UserListenerNotifier();
});
/*
class UserNotifier extends Notifier<UserModel?> {
  StreamSubscription<UserModel?>? _subscription;

  @override
  UserModel? build() {
    final authState = ref.watch(authStateNotifierProvider).value;

    // If no user is authenticated, clear any existing subscription and return null
    if (authState == null) {
      _subscription?.cancel();
      _subscription = null;
      return null;
    }

    final userRepoProv = ref.read(userRepositoryProvider);
    _listenToUserStream(userRepoProv.getUserStream(authState.uid));

    return state;
  }

  void _listenToUserStream(Stream<UserModel?> userStream) {
    // Cancel previous subscription if it exists
    _subscription?.cancel();

    // Create a new subscription
    _subscription = userStream.listen(
      (user) {
        state = user; // Update state when new data is emitted
      },
      onError: (error) {
        // Handle any errors if necessary
        state = null;
      },
    );
  }

  @override
  void dispose() {
    // Cancel the subscription when the notifier is disposed
    _subscription?.cancel();
    super.dispose();
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, UserModel?>(
  () => UserNotifier(),
);
*/
