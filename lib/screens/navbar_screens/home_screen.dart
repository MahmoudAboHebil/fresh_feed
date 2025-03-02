import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';

// ToDO: font type
// ToDO: enhance the images widgets
// ToDO: creating the loading screen and Refresh button

// note: basic article cart / recommend Article cart/ channel cart
// there are not article pagination here
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(BuildContext buildContext, GoRouterState state) =>
      const HomeScreen();
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 7,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: context.setMinSize(50),
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Image.asset(
            'assets/main_logo.png',
            height: context.setMinSize(32),
          ),
          bottom: TabBar(
            controller: _controller,
            padding: EdgeInsets.zero,
            indicatorWeight: context.setSp(2),

            // indicatorPadding: EdgeInsetsGeometry.(bottom: 0, top: 40),
            labelPadding: EdgeInsetsDirectional.only(
              start: context.setWidth(16),
              end: context.setWidth(16),
            ),
            tabAlignment: TabAlignment.start,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            physics: AlwaysScrollableScrollPhysics(),

            isScrollable: true,
            unselectedLabelColor: context.colorScheme.secondaryContainer,
            labelStyle: TextStyle(
                fontSize: context.setSp(17), fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                fontSize: context.setSp(16), fontWeight: FontWeight.w500),
            dividerHeight: 0,
            tabs: [
              Tab(
                child: Text(S.of(context).ForYou),
              ),
              Tab(
                child: Text(
                  S.of(context).Sports,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Business,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Technology,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Health,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Entertainment,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).SeeAll,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Container(
              margin: EdgeInsetsDirectional.symmetric(
                vertical: context.setWidth(10),
                horizontal: context.setHeight(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DurationArticleCarts(
                      data: articleCartData,
                    ),
                    Gap(context.setHeight(15)),
                    // Popular News
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: context.setMinSize(10),
                          vertical: context.setMinSize(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular News',
                            style: TextStyle(
                                color: context.textTheme.bodyLarge?.color
                                    ?.withOpacity(0.9),
                                fontSize: context.setSp(16),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(
                                color: context.colorScheme.tertiary
                                    .withOpacity(0.9),
                                fontSize: context.setSp(14)),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: EdgeInsetsDirectional.only(
                            bottom: context.setHeight(14)),
                        child: BasicArticleView(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

final articleCartData = [
  {
    "image":
        "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"
  },
  {
    "image":
        "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"
  },
  {
    "image":
        "https://i0.wp.com/plopdo.com/wp-content/uploads/2021/11/feature-pic.jpg?w=537&ssl=1"
  },
  {
    "image":
        "https://cdn.futura-sciences.com/cdn-cgi/image/width=1520,quality=50,format=auto/sources/images/AI-creation.jpg"
  },
  {"image": "https://www.industrialempathy.com/img/remote/ZiClJf-640w.avif"}
];
