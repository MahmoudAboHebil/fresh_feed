// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Localizationf`
  String get title {
    return Intl.message(
      'Flutter Localizationf',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get welcome {
    return Intl.message('welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Sign in to abc News`
  String get signTitle {
    return Intl.message(
      'Sign in to abc News',
      name: 'signTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Log in with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Log in with Number`
  String get loginWithPhone {
    return Intl.message(
      'Log in with Number',
      name: 'loginWithPhone',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Log In`
  String get login {
    return Intl.message('Log In', name: 'login', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `No Account?`
  String get noAccount {
    return Intl.message('No Account?', name: 'noAccount', desc: '', args: []);
  }

  /// `Create one`
  String get createOne {
    return Intl.message('Create one', name: 'createOne', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enterAValidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'enterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8`
  String get PasswordMustBAtLeast8 {
    return Intl.message(
      'Password must be at least 8',
      name: 'PasswordMustBAtLeast8',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter.`
  String get PasswordMustContainUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter.',
      name: 'PasswordMustContainUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter.`
  String get PasswordMustContainLowercase {
    return Intl.message(
      'Password must contain at least one lowercase letter.',
      name: 'PasswordMustContainLowercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one digit.`
  String get PasswordMustContainDigit {
    return Intl.message(
      'Password must contain at least one digit.',
      name: 'PasswordMustContainDigit',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character (@\$!%*?&).`
  String get PasswordMustContainSpecialChart {
    return Intl.message(
      'Password must contain at least one special character (@\\\$!%*?&).',
      name: 'PasswordMustContainSpecialChart',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameIsRequired {
    return Intl.message(
      'Name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 2 characters long.`
  String get nameMustBeAtLeast2 {
    return Intl.message(
      'Password must be at least 2 characters long.',
      name: 'nameMustBeAtLeast2',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at most 50 characters long.`
  String get nameMustBeAtMost50chart {
    return Intl.message(
      'Name must be at most 50 characters long.',
      name: 'nameMustBeAtMost50chart',
      desc: '',
      args: [],
    );
  }

  /// `Invalid name format. Use only letters, spaces, hyphens, or apostrophes.`
  String get nameInvalid {
    return Intl.message(
      'Invalid name format. Use only letters, spaces, hyphens, or apostrophes.',
      name: 'nameInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordWithoutQM {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordWithoutQM',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address linked with your account`
  String get forgotPasswordTitle {
    return Intl.message(
      'Please enter the email address linked with your account',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Re-enter Password`
  String get rePassword {
    return Intl.message(
      'Re-enter Password',
      name: 'rePassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-Password is required`
  String get rePasswordIsRequired {
    return Intl.message(
      'Re-Password is required',
      name: 'rePasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Re-Password doesn't match`
  String get rePasswordDoesNotMatch {
    return Intl.message(
      'Re-Password doesn\'t match',
      name: 'rePasswordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `No internet connection. Please check your network and try again.`
  String get noInternet {
    return Intl.message(
      'No internet connection. Please check your network and try again.',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Oops! An error occurred. Please try again.`
  String get nullUserExp {
    return Intl.message(
      'Oops! An error occurred. Please try again.',
      name: 'nullUserExp',
      desc: '',
      args: [],
    );
  }

  /// `This account already exists. Please log in.`
  String get accountAlreadyExistsExp {
    return Intl.message(
      'This account already exists. Please log in.',
      name: 'accountAlreadyExistsExp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format.`
  String get invalidEmailFormatExp {
    return Intl.message(
      'Invalid email format.',
      name: 'invalidEmailFormatExp',
      desc: '',
      args: [],
    );
  }

  /// `Oops! An error occurred. Please try again.`
  String get errorExp {
    return Intl.message(
      'Oops! An error occurred. Please try again.',
      name: 'errorExp',
      desc: '',
      args: [],
    );
  }

  /// `The email or password is incorrect. Please check your credentials and try again.`
  String get invalidCredentialExp {
    return Intl.message(
      'The email or password is incorrect. Please check your credentials and try again.',
      name: 'invalidCredentialExp',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get userDisabledExp {
    return Intl.message(
      'This account has been disabled.',
      name: 'userDisabledExp',
      desc: '',
      args: [],
    );
  }

  /// `Password reset failed. Please try again later.`
  String get resetPasswordExp {
    return Intl.message(
      'Password reset failed. Please try again later.',
      name: 'resetPasswordExp',
      desc: '',
      args: [],
    );
  }

  /// `An email has been sent to you to reset your password. Please check your inbox.`
  String get resetPasswordSuccess {
    return Intl.message(
      'An email has been sent to you to reset your password. Please check your inbox.',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Topics`
  String get Topics {
    return Intl.message('Topics', name: 'Topics', desc: '', args: []);
  }

  /// `Discover`
  String get Discover {
    return Intl.message('Discover', name: 'Discover', desc: '', args: []);
  }

  /// `Profile`
  String get Profile {
    return Intl.message('Profile', name: 'Profile', desc: '', args: []);
  }

  /// `Bookmarks`
  String get Bookmarks {
    return Intl.message('Bookmarks', name: 'Bookmarks', desc: '', args: []);
  }

  /// `Followed Channels`
  String get FollowedChannels {
    return Intl.message(
      'Followed Channels',
      name: 'FollowedChannels',
      desc: '',
      args: [],
    );
  }

  /// `General Settings`
  String get GeneralSettings {
    return Intl.message(
      'General Settings',
      name: 'GeneralSettings',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get Theme {
    return Intl.message('Theme', name: 'Theme', desc: '', args: []);
  }

  /// `Contact Us`
  String get ContactUs {
    return Intl.message('Contact Us', name: 'ContactUs', desc: '', args: []);
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message('About Us', name: 'AboutUs', desc: '', args: []);
  }

  /// `Log Out`
  String get LogOut {
    return Intl.message('Log Out', name: 'LogOut', desc: '', args: []);
  }

  /// `Choose Language`
  String get ChooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'ChooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `Spanish`
  String get Spanish {
    return Intl.message('Spanish', name: 'Spanish', desc: '', args: []);
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message('Arabic', name: 'Arabic', desc: '', args: []);
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Apply`
  String get Apply {
    return Intl.message('Apply', name: 'Apply', desc: '', args: []);
  }

  /// `Choose Theme`
  String get ChooseTheme {
    return Intl.message(
      'Choose Theme',
      name: 'ChooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `System Mode`
  String get SystemMode {
    return Intl.message('System Mode', name: 'SystemMode', desc: '', args: []);
  }

  /// `Dark Mode`
  String get DarkMode {
    return Intl.message('Dark Mode', name: 'DarkMode', desc: '', args: []);
  }

  /// `Light Mode`
  String get LightMode {
    return Intl.message('Light Mode', name: 'LightMode', desc: '', args: []);
  }

  /// `Permission Required`
  String get PermissionRequired {
    return Intl.message(
      'Permission Required',
      name: 'PermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get PhoneNumber {
    return Intl.message(
      'Phone number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Search country`
  String get SearchCountry {
    return Intl.message(
      'Search country',
      name: 'SearchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Crop Image`
  String get CropImage {
    return Intl.message('Crop Image', name: 'CropImage', desc: '', args: []);
  }

  /// `Camera`
  String get Camera {
    return Intl.message('Camera', name: 'Camera', desc: '', args: []);
  }

  /// `Gallery`
  String get Gallery {
    return Intl.message('Gallery', name: 'Gallery', desc: '', args: []);
  }

  /// `Select Image Source`
  String get SelectImageSource {
    return Intl.message(
      'Select Image Source',
      name: 'SelectImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Your email has been successfully verified`
  String get EmailVerified {
    return Intl.message(
      'Your email has been successfully verified',
      name: 'EmailVerified',
      desc: '',
      args: [],
    );
  }

  /// `A verification link has been sent to your email`
  String get SendEmailVerify {
    return Intl.message(
      'A verification link has been sent to your email',
      name: 'SendEmailVerify',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get UpdateProfile {
    return Intl.message(
      'Update Profile',
      name: 'UpdateProfile',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get ForYou {
    return Intl.message('For You', name: 'ForYou', desc: '', args: []);
  }

  /// `Business`
  String get Business {
    return Intl.message('Business', name: 'Business', desc: '', args: []);
  }

  /// `Sports`
  String get Sports {
    return Intl.message('Sports', name: 'Sports', desc: '', args: []);
  }

  /// `Health`
  String get Health {
    return Intl.message('Health', name: 'Health', desc: '', args: []);
  }

  /// `Technology`
  String get Technology {
    return Intl.message('Technology', name: 'Technology', desc: '', args: []);
  }

  /// `Entertainment`
  String get Entertainment {
    return Intl.message(
      'Entertainment',
      name: 'Entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Select Font Size`
  String get SelectFontSize {
    return Intl.message(
      'Select Font Size',
      name: 'SelectFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Extra Small`
  String get ExtraSmall {
    return Intl.message('Extra Small', name: 'ExtraSmall', desc: '', args: []);
  }

  /// `Small`
  String get Small {
    return Intl.message('Small', name: 'Small', desc: '', args: []);
  }

  /// `Medium`
  String get Medium {
    return Intl.message('Medium', name: 'Medium', desc: '', args: []);
  }

  /// `Large`
  String get Large {
    return Intl.message('Large', name: 'Large', desc: '', args: []);
  }

  /// `Extra Large`
  String get ExtraLarge {
    return Intl.message('Extra Large', name: 'ExtraLarge', desc: '', args: []);
  }

  /// `See all`
  String get SeeAll {
    return Intl.message('See all', name: 'SeeAll', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
