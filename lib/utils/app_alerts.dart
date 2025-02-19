import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';
import 'extensions.dart';
import 'languages.dart';

class AppAlerts {
  AppAlerts._();

  static void displayLanguageDialog(BuildContext context, Language initialLang,
      Function(Language lang) callBack) {
    Language selectedLanguage = initialLang;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsetsDirectional.only(
            top: 15,
            bottom: 5,
            start: 30,
            end: 30,
          ),
          actionsPadding: const EdgeInsetsDirectional.only(
            top: 0,
            bottom: 10,
            start: 15,
            end: 15,
          ),
          title: Text(
            S.of(context).ChooseLanguage,
            style: GoogleFonts.inter(
              fontSize: context.setSp(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: context.colorScheme.secondary,
          content: StatefulBuilder(builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text(
                    S.of(context).English,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: Language.en.name,
                  groupValue: selectedLanguage.name,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedLanguage = Language.stringToLanguage(value)!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    S.of(context).Spanish,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: Language.es.name,
                  groupValue: selectedLanguage.name,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    print(value);

                    setDialogState(() {
                      selectedLanguage = Language.stringToLanguage(value)!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    S.of(context).Arabic,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: Language.ar.name,
                  groupValue: selectedLanguage.name,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedLanguage = Language.stringToLanguage(value)!;
                    });
                  },
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                S.of(context).Cancel,
                style: GoogleFonts.inter(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: context.setSp(15)),
              ),
            ),
            TextButton(
              onPressed: () async {
                await callBack(selectedLanguage);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                S.of(context).Apply,
                style: GoogleFonts.inter(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: context.setSp(15)),
              ),
            ),
          ],
        );
      },
    );
  }

  static void displayThemeModeDialog(BuildContext context,
      ThemeMode initialMode, Function(ThemeMode mode) callBack) {
    int selectedModeIndex = initialMode.index;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsetsDirectional.only(
            top: 15,
            bottom: 5,
            start: 30,
            end: 30,
          ),
          actionsPadding: const EdgeInsetsDirectional.only(
            top: 0,
            bottom: 10,
            start: 15,
            end: 15,
          ),
          title: Text(
            S.of(context).ChooseTheme,
            style: GoogleFonts.inter(
              fontSize: context.setSp(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: context.colorScheme.secondary,
          content: StatefulBuilder(builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text(
                    S.of(context).SystemMode,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: ThemeMode.system.index,
                  groupValue: selectedModeIndex,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedModeIndex = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    S.of(context).DarkMode,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: ThemeMode.dark.index,
                  groupValue: selectedModeIndex,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedModeIndex = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    S.of(context).LightMode,
                    style: TextStyle(
                        color: context.textTheme.bodyLarge?.color,
                        fontSize: context.setSp(17)),
                  ),
                  value: ThemeMode.light.index,
                  groupValue: selectedModeIndex,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) {
                    setDialogState(() {
                      selectedModeIndex = value!;
                    });
                  },
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                S.of(context).Cancel,
                style: GoogleFonts.inter(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: context.setSp(15)),
              ),
            ),
            TextButton(
              onPressed: () async {
                await callBack(ThemeMode.values[selectedModeIndex]);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                S.of(context).Apply,
                style: GoogleFonts.inter(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: context.setSp(15)),
              ),
            ),
          ],
        );
      },
    );
  }

  static void displaySnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontSize: context.setSp(context.textTheme.bodyMedium!.fontSize!)),
        ),
        backgroundColor: context.colorScheme.surface,
      ),
    );
  }

  static Future<bool> displayPermissionDialog(Future<bool> Function() callBack,
      String okTextString, String content, BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).PermissionRequired),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(okTextString),
            onPressed: () async {
              bool callbackResult = await callBack();
              Navigator.pop(context, callbackResult);
            },
          ),
          TextButton(
            child: Text(S.of(context).Cancel),
            onPressed: () => Navigator.pop(context, false), // Return false
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
