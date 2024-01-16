import 'package:awesome_floating_bottom_navigation/src/bubble_painter.dart';
import 'package:awesome_floating_bottom_navigation/src/tab_item.dart';
import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  final bool isActive;
  final double bubbleRadius;
  final double maxBubbleRadius;
  final Color? bubbleColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final IconData? iconData;
  final double iconScale;
  final double? iconSize;
  final VoidCallback onTap;
  final int? itemFlex;
  final Widget? child;

  const NavigationBarItem({
    super.key,
    required this.isActive,
    required this.bubbleRadius,
    required this.maxBubbleRadius,
    required this.bubbleColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.iconData,
    required this.iconScale,
    required this.iconSize,
    required this.onTap,
    this.itemFlex,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (itemFlex == null) {
      return _buildExpanded();
    } else {
      return _buildFlexible();
    }
  }

  Widget _buildExpanded() {
    return Expanded(
      child: SizedBox.expand(
        child: buildItem(),
      ),
    );
  }

  Widget _buildFlexible() {
    return Flexible(
      flex: itemFlex ?? 1,
      child: buildItem(),
    );
  }

  Widget buildItem() {
    return CustomPaint(
      painter: BubblePainter(
        bubbleRadius: isActive ? bubbleRadius : 0,
        bubbleColor: bubbleColor,
        maxBubbleRadius: maxBubbleRadius,
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: Transform.scale(
          scale: isActive ? iconScale : 1,
          child: TabItem(
            isActive: isActive,
            iconData: iconData,
            iconSize: iconSize,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            child: child,
          ),
        ),
      ),
    );
  }
}
