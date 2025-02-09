import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class RectangleTextButton extends StatelessWidget {
  const RectangleTextButton({
    required this.text,
    this.color,
    required this.backgroundColor,
    required this.callback,
    super.key,
  });
  final String text;
  final Color? color;
  final Color backgroundColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: context.setMinSize(15),
              vertical: context.setMinSize(9)),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: backgroundColor,
          overlayColor: context.colorScheme.inverseSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.setMinSize(8)),
          )),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: context.setSp(15),
          ),
        ),
      ),
      onPressed: () async {
        await callback();
      },
    );
  }
}
