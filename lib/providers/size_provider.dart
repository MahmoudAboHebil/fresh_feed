import 'package:flutter/material.dart';

class SizeProvider extends InheritedWidget {
  final Size baseSize;
  final double width;
  final double height;

  const SizeProvider({
    super.key,
    required super.child,
    required this.baseSize,
    required this.height,
    required this.width,
  });
  static SizeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant SizeProvider oldWidget) {
    return (height != oldWidget.height ||
        width != oldWidget.width ||
        baseSize != oldWidget.baseSize);
  }
}
