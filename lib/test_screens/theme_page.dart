import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';

class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({super.key});

  @override
  ConsumerState<ThemePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Theme page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(themeProvider.notifier);
                await prov.toggleTheme(ThemeMode.light);
              },
              child: const Text('set light'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(themeProvider.notifier);
                await prov.toggleTheme(ThemeMode.dark);
              },
              child: const Text('set Dark'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final prov = ref.read(themeProvider.notifier);
                await prov.toggleTheme(ThemeMode.system);
              },
              child: const Text('set system'),
            ),
          ],
        ),
      ),
    );
  }
}
