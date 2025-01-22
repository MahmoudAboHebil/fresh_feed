import 'package:flutter/material.dart';

import '../utils/news_source_logos.dart';
import 'followed_channels_page.dart';

class TestImage extends StatefulWidget {
  const TestImage({super.key});

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final sourceLogo = sourceLogos[index]['logo'];
          Widget imageWidget;
          if (sourceLogo.contains('base64,')) {
            imageWidget = Base64Image(imageBase64: sourceLogo);
          } else {
            imageWidget = Image.network(
              sourceLogo,
              width: 100,
              height: 100,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Icon(Icons.error, size: 50);
              },
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageWidget,
              const SizedBox(
                height: 10,
              ),
            ],
          );
          ;
        },
        separatorBuilder: (context, index) => Container(
          margin: const EdgeInsets.all(15),
          height: 2,
          color: Colors.grey,
        ),
        itemCount: sourceLogos.length,
      ),
    );
  }
}
