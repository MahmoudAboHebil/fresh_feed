import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leadingChild,
    required this.titleText,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 18,
    required this.callBack,
  });
  final Widget leadingChild;
  final String titleText;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await callBack();
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.setMinSize(14),
          vertical: context.setMinSize(10),
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(context.setSp(10)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: context.setSp(14)),
              child: leadingChild,
            ),
            Expanded(
              child: Text(
                titleText,
                style: GoogleFonts.inter(
                  fontSize: context.setSp(fontSize!),
                  fontWeight: fontWeight,
                  color: context.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Icon(
              context.isRTL
                  ? Icons.keyboard_arrow_left_sharp
                  : Icons.keyboard_arrow_right_sharp,
              size: context.setSp(25),
              color: context.textTheme.bodyLarge?.color,
            )
          ],
        ),
        /*
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            titleText,
            style: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: context.textTheme.bodyLarge?.color,
            ),
          ),
          leading: leadingChild,
          trailing: Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 25,
            color: context.textTheme.bodyLarge?.color,
          ),
          horizontalTitleGap: 14,
          minVerticalPadding: 0,
          contentPadding:
              EdgeInsetsDirectional.only(start: 14, end: 15, bottom: 10, top: 10),
          dense: true,
          onTap: () {
            callBack();
          },
        ),

         */
      ),
    );
  }
}
