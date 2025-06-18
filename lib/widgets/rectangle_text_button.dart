import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:gap/gap.dart';

class RectangleTextButton extends StatefulWidget {
  const RectangleTextButton({
    required this.text,
    this.color,
    this.fontSize = 14,
    this.enable = true,
    this.expanded = true,
    this.icon,
    this.verticalPadding = 9.0,
    this.horizontalPadding = 15.0,
    required this.backgroundColor,
    required this.callback,
    super.key,
  });
  final String text;
  final Color? color;
  final bool expanded;
  final bool enable;
  final Widget? icon;
  final double? verticalPadding;
  final double horizontalPadding;
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
    Color? color =
        widget.enable ? widget.color : widget.color?.withOpacity(0.7);
    Color backgroundColor = widget.enable
        ? widget.backgroundColor
        : widget.backgroundColor.withOpacity(0.7);
    return SizedBox(
      width: widget.expanded ? context.screenWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: context.setMinSize(widget.horizontalPadding),
                vertical: context.setMinSize(widget.verticalPadding!)),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: backgroundColor,
            overlayColor: context.colorScheme.inverseSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: isLoading ? 0.0 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: context.setSp(widget.fontSize!),
                    ),
                  ),
                  Gap(context.setWidth(8)),
                  widget.icon ?? SizedBox(),
                ],
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
          if (widget.enable) {
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
          }
        },
      ),
    );
  }
}
