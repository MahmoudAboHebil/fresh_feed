import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class TestLoading extends StatelessWidget {
  const TestLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final itemHeight = context.setHeight(116);
    final itemNum = (context.screenHeight / itemHeight).floor();

    return Center(
      child: ListView.builder(
        itemCount: itemNum,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: context.setHeight(8),
                  horizontal: context.setWidth(16)),
              height: context.setHeight(100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
