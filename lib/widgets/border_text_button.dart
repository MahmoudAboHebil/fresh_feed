import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class BorderTextButton extends StatelessWidget {
  const BorderTextButton({
    required this.text,
    this.textSize = 16,
    this.padding,
    this.borderColor,
    required this.color,
    required this.backgroundColor,
    required this.callback,
    super.key,
  });
  final String text;
  final Color color;
  final Size? padding;
  final Color? borderColor;
  final double textSize;
  final Color backgroundColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.setWidth(padding?.width ?? 15),
            vertical: context.setWidth(padding?.height ?? 6)),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: context.colorScheme.inverseSurface,
        backgroundColor: backgroundColor,
        shape: StadiumBorder(
          side: BorderSide(color: borderColor ?? color),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: context.setMinSize(textSize),
        ),
      ),
      onPressed: () async {
        await callback();
      },
    );
  }
}
