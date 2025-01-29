import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/language_provider.dart';

import '../generated/l10n.dart';
import '../utils/languages.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(S.of(context).welcome),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Text(S.of(context).name),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(languageProvider.notifier);
                await prov.toggleLanguage(Language.ar);
              },
              child: const Text('set Arabic'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(languageProvider.notifier);
                await prov.toggleLanguage(Language.en);
              },
              child: const Text('set English'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(languageProvider.notifier);
                await prov.toggleLanguage(Language.es);
              },
              child: const Text('set Spanish'),
            ),
          ],
        ),
      ),
    );
  }
}
