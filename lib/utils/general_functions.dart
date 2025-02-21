import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../generated/l10n.dart';

class GeneralFunctions {
  final BuildContext context;
  const GeneralFunctions(this.context);
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
}
