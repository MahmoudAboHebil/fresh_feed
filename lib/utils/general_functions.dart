import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../generated/l10n.dart';

class GeneralFunctions {
  final BuildContext context;

  const GeneralFunctions(this.context);

  static List<T> getRandomItems<T>(List<T> originalList, int count) {
    final random = Random();

    // Make a copy of the list to avoid modifying the original
    final listCopy = List<T>.from(originalList);

    // Shuffle the copy
    listCopy.shuffle(random);

    // Take up to `count` items
    return listCopy.take(count).toList();
  }

  static String buildNewsQuery(String title) {
    // Common stopwords to skip
    final stopwords = {
      'the',
      'is',
      'in',
      'at',
      'on',
      'a',
      'an',
      'to',
      'of',
      'and',
      'for'
    };

    // Split the title into words
    final words = title
        .toLowerCase()
        .split(RegExp(r'\W+'))
        .where((w) => w.isNotEmpty && !stopwords.contains(w))
        .toList();

    // Recombine important keywords into query terms
    var queryTerms =
        words.take(6).map((w) => w).toList(); // Limit to top 6 words
    queryTerms = getRandomItems(queryTerms, 2);

    final queryString = queryTerms.join(' ');
    return queryString;
  }

  static String timeAgo(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString).toLocal();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${(difference.inDays / 365).floor()} years ago';
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).emailIsRequired;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return S.of(context).enterAValidEmail;
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return S.of(context).passwordIsRequired;
    }
    if (password.length < 8) {
      return S.of(context).PasswordMustBAtLeast8;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return S.of(context).PasswordMustContainUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return S.of(context).PasswordMustContainLowercase;
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return S.of(context).PasswordMustContainDigit;
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
      return S.of(context).PasswordMustContainSpecialChart;
    }
    return null;
  }

  String? nameValidator(String? name) {
    final nameRegex = RegExp(
        r"^[A-Za-zÀ-ÖØ-öø-ÿ\u0600-\u06FF\u0400-\u04FF\u4E00-\u9FFF\u3040-\u30FF' -]{2,50}$");
    if (name == null || name.isEmpty || name.trim().isEmpty) {
      return S.of(context).nameIsRequired;
    }

    if (name.length < 2) {
      return S.of(context).nameMustBeAtLeast2;
    }
    if (name.length > 50) {
      return S.of(context).nameMustBeAtMost50chart;
    }
    if (!nameRegex.hasMatch(name)) {
      return S.of(context).nameInvalid;
    }
    return null;
  }

  Future<PhoneNumber> getPhoneNumber(
      String phoneNumber, String? isoCode) async {
    try {
      PhoneNumber number;
      if (isoCode != null) {
        number = await PhoneNumber.getRegionInfoFromPhoneNumber(
            phoneNumber, isoCode);
      } else {
        number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
      }
      return number;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickImage({
    required ImageSource source,
    Future<File> Function(File file)? cropImage,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return null;

      if (cropImage == null) {
        return File(pickedFile.path);
      } else {
        final file = File(pickedFile.path);
        return await cropImage(file);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> cropImage(File imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarTitle: S.of(context).CropImage,
            toolbarColor: const Color(0xfff44236),
            toolbarWidgetColor: Colors.white,
            // hideBottomControls: true,
            // lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: S.of(context).CropImage,
            rotateClockwiseButtonHidden: false,
            aspectRatioLockEnabled: true,
            resetButtonHidden: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );
      if (croppedFile == null) return null;
      return File(croppedFile.path);
    } catch (e) {
      rethrow;
    }
  }
}
