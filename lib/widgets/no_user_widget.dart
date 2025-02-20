import 'package:flutter/material.dart';
import 'package:fresh_feed/config/config.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/rectangle_text_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';

class NoUserWidget extends StatelessWidget {
  const NoUserWidget({super.key});

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
                "assets/sign_in.jpg",
                width: context.setMinSize(400),
              ),
            ),
            Gap(context.setMinSize(40)),
            Text(
              'Sign In Required!',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
            ),
            Gap(context.setMinSize(25)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                ' Please sign in to access all features and enjoy a complete experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.setSp(15)),
              ),
            ),
            Gap(!context.isLandScape ? 70 : 30),
            RectangleTextButton(
              callback: () async {
                context.goNamed(RouteName.signIn);
              },
              color: context.colorScheme.onPrimary,
              backgroundColor: context.colorScheme.primary,
              text: S.of(context).login,
            ),
            Gap(context.setMinSize(30)),
          ],
        ),
      ),
    );
  }
}
