import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await PermissionHandlerService.requestPermissions();

  runApp(
    ProviderScope(
      child: FreshFeedApp(),
    ),
  );
}

final x = [
  "abc-news",
  "abc-news-au",
  "aftenposten",
  "al-jazeera-english",
  "ansa",
  "argaam",
  "ars-technica",
  "ary-news",
  "associated-press",
  "australian-financial-review",
  "axios",
  "bbc-news",
  "bbc-sport",
  "bild",
  "blasting-news-br",
  "bleacher-report",
  "bloomberg",
  "breitbart-news",
  "business-insider",
  "buzzfeed",
  "cbc-news",
  "cbs-news",
  "cnn",
  "cnn-es",
  "crypto-coins-news",
  "der-tagesspiegel",
  "die-zeit",
];
