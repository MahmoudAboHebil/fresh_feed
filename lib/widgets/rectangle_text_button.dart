import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class RectangleTextButton extends StatefulWidget {
  const RectangleTextButton({
    required this.text,
    this.color,
    this.fontSize = 14,
    this.verticalPadding = 9.0,
    required this.backgroundColor,
    required this.callback,
    super.key,
  });
  final String text;
  final Color? color;
  final double? verticalPadding;
  final double? fontSize;
  final Color backgroundColor;
  final Function callback;

  @override
  State<RectangleTextButton> createState() => _RectangleTextButtonState();
}

class _RectangleTextButtonState extends State<RectangleTextButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: context.setMinSize(15),
                vertical: context.setMinSize(widget.verticalPadding!)),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: widget.backgroundColor,
            overlayColor: context.colorScheme.inverseSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: isLoading ? 0.0 : 1.0,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.bold,
                  fontSize: context.setSp(widget.fontSize!),
                ),
              ),
            ),
            Opacity(
              opacity: !isLoading ? 0.0 : 1.0,
              child: SizedBox(
                height: context.setMinSize(24),
                width: context.setMinSize(24),
                child: CircularProgressIndicator(
                  color: context.colorScheme.onPrimary,
                  strokeWidth: context.setSp(3),
                ),
              ),
            )
          ],
        ),
        onPressed: () async {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            await widget.callback();
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
      ),
    );
  }
}
