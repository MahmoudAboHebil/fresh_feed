import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class LoginButton extends StatefulWidget {
  final String text;
  final Widget icon;
  final double iconSize;

  final Function callBack;

  const LoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconSize,
    required this.callBack,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: isLoading
            ? EdgeInsetsDirectional.symmetric(
                horizontal: context.setMinSize(10),
                vertical: context.setMinSize(8),
              )
            : EdgeInsetsDirectional.symmetric(
                horizontal: context.setMinSize(15),
                vertical: context.setMinSize(12),
              ),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: context.colorScheme.inverseSurface,
        backgroundColor: context.colorScheme.secondary,
        shape: StadiumBorder(),
        elevation: 3,
      ),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        await widget.callBack();
        setState(() {
          isLoading = false;
        });
      },
      child: !isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.icon,
                Spacer(
                  flex: 6,
                ),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorScheme.secondaryContainer,
                    fontSize: context.setSp(15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(
                  flex: 7,
                ),
              ],
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: context.setMinSize(widget.iconSize + 10),
                  width: context.setMinSize(widget.iconSize + 10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                widget.icon
              ],
            ),
    );
  }
}
