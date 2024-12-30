import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'firebase_options.dart';

///ToDO: enable user to verified its email with error handling
///ToDO: enable user to reset its password with error handling
///ToDO: enable user sign in with phone with error handling

///(important because currently i update
/// the profile whenever user logged in and signed up, so take care) => (done now
///  it is  save)
///ToDO: enable user profile within firestore and firebase
///ToDO: handling the authentication process if network connection is lost

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: FreshFeedApp()));
}
