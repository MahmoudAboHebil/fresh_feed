import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/rectangle_text_button.dart';
import 'package:gap/gap.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.buttonText, required this.callBack});
  final String? buttonText;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsetsDirectional.symmetric(
          vertical: context.setHeight(10),
          horizontal: context.setWidth(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(context.setMinSize(!context.isLandScape ? 130 : 30)),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/error_img.jpg",
                width: context.setMinSize(400),
              ),
            ),
            Gap(context.setMinSize(40)),
            Text(
              'Opps!',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
            ),
            Gap(context.setMinSize(25)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'We’re sorry. Something went wrong please try again..',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.setSp(15)),
              ),
            ),
            buttonText != null ? Gap(context.setMinSize(70)) : SizedBox(),
            buttonText != null
                ? SizedBox(
                    child: RectangleTextButton(
                      callback: () async {
                        await callBack!();
                      },
                      color: context.colorScheme.onPrimary,
                      backgroundColor: context.colorScheme.primary,
                      text: buttonText!,
                    ),
                  )
                : SizedBox(),
            Gap(context.setMinSize(30)),
          ],
        ),
      ),
    );
  }
}
