import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'firebase_options.dart';

///ToDO: enable user to verified its email with error handling
///ToDO: enable user to reset its password with error handling
///ToDO: enable user sign in with phone with error handling

///(important because currently i update
/// the profile whenever user logged in and signed up, so take care)
///ToDO: enable user profile within firestore and firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: FreshFeedApp()));
}
