import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';

// ToDO: font type

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
              start: context.setMinSize(16),
              end: context.setMinSize(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ArticleCart()],
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

class ArticleCart extends StatelessWidget {
  const ArticleCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        height: context.setWidth(205),
        width: context.setWidth(420),
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960")),
          // https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black87,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: context.setWidth(10),
                horizontal: context.setWidth(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: context.setWidth(4),
                      horizontal: context.setWidth(7),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.colorScheme.primary),
                    child: Text(
                      'Topstory',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'istana pastikan Danauntara siapkan investasi di bidang teknologi',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Gap(10),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Gap(10),
                            Text(
                              '1 day ago',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
