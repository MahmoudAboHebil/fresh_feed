import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/general_functions.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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

  static void displaySnackBar(String message, BuildContext context,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontSize: context.setSp(context.textTheme.bodyMedium!.fontSize!)),
        ),
        backgroundColor: backgroundColor ?? context.colorScheme.surface,
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

  static Future<File?> showImagePickerOptions(BuildContext context) async {
    final GeneralFunctions functions = GeneralFunctions(context);
    return await showModalBottomSheet<File?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(minWidth: context.screenWidth),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.setMinSize(16)),
            ), // Optional rounded corners
          ),
          padding: EdgeInsetsDirectional.only(
              top: context.setMinSize(20), bottom: context.setMinSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).SelectImageSource,
                style: TextStyle(
                    fontSize: context.setSp(19),
                    fontWeight: FontWeight.w600,
                    color:
                        context.textTheme.bodyLarge?.color!.withOpacity(0.80)),
              ),
              Gap(context.setHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            final pickImage = await functions.pickImage(
                                source: ImageSource.camera);
                            if (pickImage == null) Navigator.pop(context, null);

                            final image = await functions.cropImage(pickImage!);
                            if (image == null) Navigator.pop(context, null);

                            Navigator.pop(context, image);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: context.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.all(context.setMinSize(20)),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: context.colorScheme.primary,
                              size: context.setMinSize(45),
                            ),
                          ),
                        ),
                      ),
                      Gap(context.setHeight(10)),
                      Text(
                        S.of(context).Camera,
                        style: TextStyle(
                            fontSize: context.setSp(14),
                            fontWeight: FontWeight.w500,
                            color: context.textTheme.bodyLarge?.color),
                      ),
                    ],
                  ),
                  Gap(context.setHeight(70)),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            final pickImage = await functions.pickImage(
                                source: ImageSource.gallery);
                            if (pickImage == null) Navigator.pop(context, null);

                            final image = await functions.cropImage(pickImage!);
                            if (image == null) Navigator.pop(context, null);

                            Navigator.pop(context, image);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: context.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.all(context.setMinSize(20)),
                            child: Icon(
                              Icons.photo_library,
                              color: context.colorScheme.primary,
                              size: context.setMinSize(45),
                            ),
                          ),
                        ),
                      ),
                      Gap(context.setHeight(10)),
                      Text(
                        S.of(context).Gallery,
                        style: TextStyle(
                            fontSize: context.setSp(14),
                            fontWeight: FontWeight.w500,
                            color: context.textTheme.bodyLarge?.color),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
