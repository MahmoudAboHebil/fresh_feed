import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/models/news_models/news_article.dart';
import '../loading_components/shell_loading.dart';

class WebViewArticlePage extends StatefulWidget {
  const WebViewArticlePage({required this.article, super.key});
  final Article article;

  @override
  State<WebViewArticlePage> createState() => _WebViewArticlePageState();
}

class _WebViewArticlePageState extends State<WebViewArticlePage> {
  late WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.article.url!),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          await controller.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: context.textTheme.bodyLarge?.color,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          toolbarHeight: context.setMinSize(50),
          scrolledUnderElevation: 0,
          title: Text(
            widget.article.source?.name ?? "",
            style: TextStyle(
                fontSize: context.setSp(23),
                color: context.textTheme.bodyLarge?.color),
          ),
        ),
        body: !isLoading
            ? WebViewWidget(
                controller: controller,
              )
            : ShellLoading(),
      ),
    );
  }
}
