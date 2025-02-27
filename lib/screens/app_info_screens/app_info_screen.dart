import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';

class AppInfoScreen extends ConsumerWidget {
  final String title;
  const AppInfoScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: context.textTheme.bodyLarge?.color,
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: TextStyle(
              fontSize: context.setSp(23),
              color: context.textTheme.bodyLarge?.color),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsetsDirectional.symmetric(
            vertical: context.setWidth(15),
            horizontal: context.setHeight(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(18)),
              Text(
                'Disclaimers',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
              ),
              Gap(context.setHeight(18)),
              Text(
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock.the industry",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(14)),
              Text(
                "Lorem Ipsum is simply dummy text of the Latin printing and typesetting industry.Latin professor at Hampden-Sydney College in Virginia.",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(18)),
              Text(
                'Limitaion on Liabillity',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
              ),
              Gap(context.setHeight(18)),
              Text(
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock.the industry",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(14)),
              Text(
                "Lorem Ipsum is simply dummy text of the Latin printing and typesetting industry.Latin professor at Hampden-Sydney College in Virginia.",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(18)),
              Text(
                'Copyright Policy',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: context.setSp(16)),
              ),
              Gap(context.setHeight(18)),
              Text(
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock.the industry",
                style: TextStyle(fontSize: context.setSp(14)),
              ),
              Gap(context.setHeight(14)),
            ],
          ),
        ),
      ),
    );
  }
}
