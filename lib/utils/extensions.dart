import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.of(this).size;

  /// responsive extensions
  bool get isLandScape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenHeight => isLandScape
      ? MediaQuery.of(this).size.width
      : MediaQuery.of(this).size.height;

  double get screenWidth => isLandScape
      ? MediaQuery.of(this).size.height
      : MediaQuery.of(this).size.width;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidth => sizeProvider.width / sizeProvider.baseSize.width;
  double get scaleHeight => sizeProvider.height / sizeProvider.baseSize.height;

  double setHeight(num num) {
    return num * scaleHeight;
  }

  double setWidth(num num) {
    return num * scaleWidth;
  }

  double setSp(num fontSize) {
    return fontSize * scaleWidth;
  }

  double setMinSize(num size) {
    return size * min(scaleWidth, scaleHeight);
  }
}
