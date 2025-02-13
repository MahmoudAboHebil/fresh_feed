import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fresh_feed/providers/providers.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.of(this).size;
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// responsive extensions
  bool get isLandScape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenHeight => isLandScape
      ? min(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height)
      : MediaQuery.of(this).size.height;

  double get screenWidth => isLandScape
      ? max(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height)
      : MediaQuery.of(this).size.width;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidth =>
      (sizeProvider.width) /
      (isLandScape
          ? max(sizeProvider.baseSize.width, sizeProvider.baseSize.height)
          : sizeProvider.baseSize.width);
  double get scaleHeight =>
      sizeProvider.height /
      (isLandScape
          ? min(sizeProvider.baseSize.width, sizeProvider.baseSize.height)
          : sizeProvider.baseSize.height);

  /*

  double get screenHeight => isLandScape
      ? min(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height)
      : MediaQuery.of(this).size.height;

  double get screenWidth => isLandScape
      ? max(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height)
      : MediaQuery.of(this).size.width;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidth =>
      (sizeProvider.width) /
      (isLandScape
          ? max(sizeProvider.baseSize.width, sizeProvider.baseSize.height)
          : sizeProvider.baseSize.width);
  double get scaleHeight =>
      sizeProvider.height /
      (isLandScape
          ? min(sizeProvider.baseSize.width, sizeProvider.baseSize.height)
          : sizeProvider.baseSize.height);

   */

  double setHeight(num num) {
    return num * scaleHeight;
  }

  double setWidth(num num) {
    return num * scaleWidth;
  }

  double setHeightScreenBase(double perc) {
    return screenHeight * perc;
  }

  double setWidthScreenBase(double perc) {
    return screenWidth * perc;
  }

  double setSp(num fontSize) {
    return fontSize * scaleWidth;
  }

  double setMinSize(num size) {
    return size * min(scaleWidth, scaleHeight);
  }
  /* a responsive case

        base (360 | 690 )
        screen (1280 | 1880 )
        scale ( 3.55 | 2.72 )
         14* 3.55


        base (200 | 200 )
        screen ( setMinSize(200)= 544 | setMinSize(200)= 544 )
        scale ( 2.72 | 2.72 )
        setHeight() == setWidth() == setMinSize() == setSp()
         14*2.72

   */
}
