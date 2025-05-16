import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';

// size
class ChannelCart extends StatelessWidget {
  const ChannelCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: context.setWidth(10),
        horizontal: context.setWidth(10),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(context.setSp(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
