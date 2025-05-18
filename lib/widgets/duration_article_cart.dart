import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/article_cart.dart';
import 'package:gap/gap.dart';

import '../data/models/news_models/news_article.dart';

class DurationArticleCarts extends StatefulWidget {
  const DurationArticleCarts({
    super.key,
    required this.articles,
    this.duration = const Duration(milliseconds: 500),
  });
  final List<Article> articles;
  final Duration duration;

  @override
  State<DurationArticleCarts> createState() => _DurationArticleCartsState();
}

class _DurationArticleCartsState extends State<DurationArticleCarts> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late final int _totalPages;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _totalPages = widget.articles.isEmpty ? 5 : widget.articles.length;
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < _totalPages - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: widget.duration,
          curve: Curves.easeInOut,
        );
      } else {
        _currentIndex = 0;
        _pageController.jumpToPage(_currentIndex);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onIndicatorTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: widget.duration,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.setWidth(205),
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: List.generate(
                widget.articles.length,
                (index) {
                  return ArticleCart(article: widget.articles[index]);
                },
              )),
        ),
        Gap(context.setWidth(14)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_totalPages, (index) {
            return GestureDetector(
              onTap: () => _onIndicatorTapped(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: context.setWidth(5)),
                width: _currentIndex == index
                    ? context.setWidth(12)
                    : context.setWidth(9),
                height: _currentIndex == index
                    ? context.setWidth(12)
                    : context.setWidth(9),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? context.colorScheme.primary
                      : Colors.grey,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
