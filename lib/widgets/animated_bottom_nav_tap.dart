import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/utils/navbar_item.dart';

class AnimatedBottomNavTap extends ConsumerWidget {
  const AnimatedBottomNavTap({
    required this.icon,
    required this.isLight,
    required this.navItem,
    required this.text,
    required this.callBack,
    this.activeIcon,
    this.iconSize = 26,
    super.key,
  });
  final IconData icon;
  final String text;
  final bool isLight;
  final double iconSize;
  final IconData? activeIcon;
  final NavbarItem navItem;
  final Function callBack;

  @override
  Widget build(BuildContext context, ref) {
    final navProv = ref.watch(navBarProvider);
    bool expanded = navProv == navItem;

    final IconData activeTapIcon =
        (expanded && activeIcon != null) ? activeIcon! : icon;
    final Color textColor;
    if (isLight) {
      if (expanded) {
        textColor = const Color(0xff292929);
      } else {
        textColor = const Color(0xff9b9b9b);
      }
    } else {
      if (expanded) {
        textColor = Colors.white;
      } else {
        textColor = const Color(0xff949494);
      }
    }

    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () async {
        if (navProv != navItem) {
          ref.read(navBarProvider.notifier).state = navItem;
        }

        await callBack();
      },
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: context.setMinSize(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(activeTapIcon,
                color: textColor, size: context.setMinSize(iconSize)),
            AnimatedSize(
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOutQuart,
              child: AnimatedOpacity(
                opacity: expanded ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 650),
                child: expanded
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: context.setMinSize(3)),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: textColor,
                            fontSize: context.setWidth(15),
                          ),
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
