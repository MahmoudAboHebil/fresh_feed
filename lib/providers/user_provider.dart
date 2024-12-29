import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseService().authStateChanges();
});

final userProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState.value == null) const Stream.empty();

  final userRepoProv = ref.read(userRepositoryProvider);

  return userRepoProv.getUserStream(authState.value!.uid);
});
