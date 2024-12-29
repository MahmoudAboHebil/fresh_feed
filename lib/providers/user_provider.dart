import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

//user login => save firestore => listen to firestore => get current user

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseService().authStateChanges();
});

final userProvider =
    StreamProvider.family<UserModel?, BuildContext>((ref, context) {
  final authState = ref.watch(authStateProvider);
  if (authState.value == null) {
    return Stream.value(null);
  }

  final userRepoProv = ref.read(userRepositoryProvider);

  return userRepoProv.getUserStream(authState.value!.uid, context);
});
