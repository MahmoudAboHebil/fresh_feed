import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/rectangle_text_button.dart';
import 'package:gap/gap.dart';

class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({super.key});

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
                "assets/no_network.jpg",
                width: context.setMinSize(310),
              ),
            ),
            Gap(context.setMinSize(40)),
            Text(
              'You’re offline',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
            ),
            Gap(context.setMinSize(25)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Please connect to the internet and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.setSp(15)),
              ),
            ),
            Gap(context.setMinSize(!context.isLandScape ? 70 : 30)),
            SizedBox(
              child: RectangleTextButton(
                callback: () async {
                  await Future.delayed(const Duration(seconds: 3));
                },
                color: context.colorScheme.onPrimary,
                backgroundColor: context.colorScheme.primary,
                text: 'Retry',
              ),
            ),
            Gap(context.setMinSize(30)),
          ],
        ),
      ),
    );
  }
}
