//  Created by Bomsamdi on 2024
//  Copyright © 2024 Bomsamdi. All rights reserved.
import 'dart:ui';

import 'package:flutter/material.dart';

import 'around_custom_painter.dart';
import 'navigation_bar_item.dart';
import 'safe_area_values.dart';

/// Signature for a function that creates a widget for a given index & state.
/// Used by [AwesomeFloatingBottomNavigation.builder].
///
/// Named `AwesomeTabBuilder` rather than `IndexedWidgetBuilder`, which is
/// already declared by `package:flutter/material.dart` with a different
/// signature - having both imported made the name ambiguous and the builder
/// constructor unusable.
typedef AwesomeTabBuilder = Widget Function(int index, bool isActive);

/// How the items are laid out inside the bar.
enum NavigationBarType {
  /// Items share the full width of the bar.
  expand,

  /// Items are grouped in the middle, with empty space on both sides.
  center,
}

class AwesomeFloatingBottomNavigation extends StatefulWidget {
  /// Type of navigation bar.
  final NavigationBarType navigationBarType;

  /// The amount of space on left and right side of [AwesomeFloatingBottomNavigation].
  final int outerFlex;

  /// The amount of space for each item.
  final int itemFlex;

  /// Widgets to render in the tab bar.
  final AwesomeTabBuilder? tabBuilder;

  /// Total item count.
  final int? itemCount;

  /// Icon data to render in the tab bar.
  final List<IconData>? icons;

  /// Handler which is passed every updated active index.
  final ValueChanged<int> onTap;

  /// Current index of selected tab bar item.
  final int activeIndex;

  /// Optional custom size for each tab bar icon. Default is 24.
  final double? iconSize;

  /// Optional custom tab bar height. Default is 56.
  final double? height;

  /// Optional custom notch margin for Floating. Default is 8.
  final double? notchMargin;

  /// Optional custom maximum spread radius for splash selection animation. Default is 24.
  final double splashRadius;

  /// Optional custom splash selection animation speed. Default is 300 milliseconds.
  final int? splashSpeedInMilliseconds;

  /// Optional custom tab bar corner radius. Default is 0.
  final double? cornerRadius;

  /// Optional custom tab bar background color. Default is [Colors.white].
  final Color? backgroundColor;

  /// Optional custom splash selection animation color. Default is [Colors.purple].
  final Color? splashColor;

  /// Optional custom currently selected tab bar [IconData] color. Default is [Colors.deepPurpleAccent]
  final Color? activeColor;

  /// Optional custom currently unselected tab bar [IconData] color. Default is [Colors.black]
  final Color? inactiveColor;

  /// Free space width between tab bar items. The preferred width is equal to total width of [FloatingActionButton] and double [notchMargin].
  /// Default is 72.
  final double? gapWidth;

  /// Optional custom tab bar elevation. Default is 8.
  final double? elevation;

  /// Optional custom tab bar padding. Default is 0.
  final EdgeInsets? padding;

  /// Optional custom shadow around the navigation bar.
  final Shadow? shadow;

  /// Specifies whether to avoid system intrusions for specific sides
  final SafeAreaValues safeAreaValues;

  /// Optional custom border color around the navigation bar. Default is [Colors.transparent].
  final Color? borderColor;

  /// Optional custom border width around the navigation bar. Default is 2.0.
  final double? borderWidth;

  /// Optional background gradient.
  ///
  /// If this is specified, [backgroundColor] has no effect.
  final Gradient? backgroundGradient;

  /// Whether blur effect should be applied.
  ///
  /// Makes sense only if [backgroundColor] opacity is < 1.
  final bool blurEffect;

  /// Optional scale effect factor. Default is 1.
  ///
  /// To disable scale effect set value of 0.
  final double scaleFactor;

  /// Optional labels announced by screen readers, one per item.
  ///
  /// Icons carry no text, so without these an item is announced only as a
  /// selected button. When given, the list length must match the number of
  /// items.
  final List<String>? semanticLabels;

  static const double _defaultSplashRadius = 24.0;
  static const Color _defaultSplashColor = Colors.purple;
  static const int _defaultSplashSpeedInMilliseconds = 300;

  /// Optional custom tab bar space on left and right of widget. Default is 0.
  final double leftAndRightBonusPadding;

  AwesomeFloatingBottomNavigation._internal({
    super.key,
    required this.activeIndex,
    required this.onTap,
    this.tabBuilder,
    this.itemCount,
    this.icons,
    this.height,
    this.splashRadius = _defaultSplashRadius,
    this.splashSpeedInMilliseconds,
    this.notchMargin,
    this.backgroundColor,
    this.splashColor,
    this.activeColor,
    this.inactiveColor,
    this.cornerRadius,
    this.iconSize,
    this.gapWidth,
    this.elevation,
    this.padding,
    this.shadow,
    this.borderColor,
    this.borderWidth,
    this.safeAreaValues = const SafeAreaValues(),
    this.backgroundGradient,
    this.blurEffect = false,
    this.scaleFactor = 1.0,
    this.leftAndRightBonusPadding = 0.0,
    this.navigationBarType = NavigationBarType.center,
    this.outerFlex = 4,
    this.itemFlex = 3,
    this.semanticLabels,
  }) : assert(
         icons != null || itemCount != null,
         'Provide either icons or itemCount',
       ),
       assert(
         ((itemCount ?? icons!.length) >= 2) &&
             ((itemCount ?? icons!.length) <= 5),
         'The navigation bar supports between 2 and 5 items',
       ),
       assert(
         semanticLabels == null ||
             semanticLabels.length == (itemCount ?? icons!.length),
         'semanticLabels must have one entry per item',
       );

  AwesomeFloatingBottomNavigation({
    Key? key,
    required List<IconData> icons,
    required int activeIndex,
    required ValueChanged<int> onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    Color? activeColor,
    Color? inactiveColor,
    double? cornerRadius,
    double? iconSize,
    double? gapWidth,
    double? elevation,
    EdgeInsets? padding,
    Shadow? shadow,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Gradient? backgroundGradient,
    bool blurEffect = false,
    double scaleFactor = 1.0,
    double leftAndRightBonusPadding = 0.0,
    NavigationBarType navigationBarType = NavigationBarType.center,
    int outerFlex = 4,
    int itemFlex = 3,
    List<String>? semanticLabels,
  }) : this._internal(
         key: key,
         icons: icons,
         activeIndex: activeIndex,
         onTap: onTap,
         height: height,
         splashRadius: splashRadius ?? _defaultSplashRadius,
         splashSpeedInMilliseconds: splashSpeedInMilliseconds,
         notchMargin: notchMargin,
         backgroundColor: backgroundColor,
         splashColor: splashColor,
         activeColor: activeColor,
         inactiveColor: inactiveColor,
         cornerRadius: cornerRadius ?? 0,
         iconSize: iconSize,
         gapWidth: gapWidth,
         elevation: elevation,
         padding: padding ?? EdgeInsets.zero,
         shadow: shadow,
         borderColor: borderColor,
         borderWidth: borderWidth,
         safeAreaValues: safeAreaValues,
         backgroundGradient: backgroundGradient,
         blurEffect: blurEffect,
         scaleFactor: scaleFactor,
         leftAndRightBonusPadding: leftAndRightBonusPadding,
         navigationBarType: navigationBarType,
         outerFlex: outerFlex,
         itemFlex: itemFlex,
         semanticLabels: semanticLabels,
       );

  AwesomeFloatingBottomNavigation.builder({
    Key? key,
    required int itemCount,
    required AwesomeTabBuilder tabBuilder,
    required int activeIndex,
    required ValueChanged<int> onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    double? cornerRadius,
    double? gapWidth,
    double? elevation,
    EdgeInsets? padding,
    Shadow? shadow,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Gradient? backgroundGradient,
    bool blurEffect = false,
    double scaleFactor = 1.0,
    double leftAndRightBonusPadding = 0.0,
    NavigationBarType navigationBarType = NavigationBarType.center,
    int outerFlex = 4,
    int itemFlex = 3,
    List<String>? semanticLabels,
  }) : this._internal(
         key: key,
         tabBuilder: tabBuilder,
         itemCount: itemCount,
         activeIndex: activeIndex,
         onTap: onTap,
         height: height,
         splashRadius: splashRadius ?? _defaultSplashRadius,
         splashSpeedInMilliseconds: splashSpeedInMilliseconds,
         notchMargin: notchMargin,
         backgroundColor: backgroundColor,
         splashColor: splashColor,
         cornerRadius: cornerRadius ?? 0,
         gapWidth: gapWidth,
         elevation: elevation,
         padding: padding ?? EdgeInsets.zero,
         shadow: shadow,
         borderColor: borderColor,
         borderWidth: borderWidth,
         safeAreaValues: safeAreaValues,
         backgroundGradient: backgroundGradient,
         blurEffect: blurEffect,
         scaleFactor: scaleFactor,
         leftAndRightBonusPadding: leftAndRightBonusPadding,
         navigationBarType: navigationBarType,
         outerFlex: outerFlex,
         itemFlex: itemFlex,
         semanticLabels: semanticLabels,
       );

  @override
  State<AwesomeFloatingBottomNavigation> createState() =>
      _AwesomeFloatingBottomNavigationState();
}

class _AwesomeFloatingBottomNavigationState
    extends State<AwesomeFloatingBottomNavigation>
    with SingleTickerProviderStateMixin {
  /// One controller for the lifetime of this state. It used to be recreated on
  /// every `didUpdateWidget`, which leaked a ticker per rebuild and threw
  /// "disposed with an active Ticker" once the bar left the tree.
  late final AnimationController _bubbleController;
  late final CurvedAnimation _bubble;

  double _bubbleRadius = 0;
  double _iconScale = 1;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: Duration(
        milliseconds:
            widget.splashSpeedInMilliseconds ??
            AwesomeFloatingBottomNavigation._defaultSplashSpeedInMilliseconds,
      ),
      vsync: this,
    );
    _bubble = CurvedAnimation(parent: _bubbleController, curve: Curves.linear)
      ..addListener(_onBubbleTick);
  }

  @override
  void didUpdateWidget(AwesomeFloatingBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.splashSpeedInMilliseconds !=
        oldWidget.splashSpeedInMilliseconds) {
      _bubbleController.duration = Duration(
        milliseconds:
            widget.splashSpeedInMilliseconds ??
            AwesomeFloatingBottomNavigation._defaultSplashSpeedInMilliseconds,
      );
    }
    // Only a change of selection animates. Animating on every rebuild replayed
    // the splash whenever anything above this widget rebuilt.
    if (widget.activeIndex != oldWidget.activeIndex) {
      _bubbleController.forward(from: 0);
    }
  }

  void _onBubbleTick() {
    setState(() {
      final double progress = _bubble.value;
      _bubbleRadius = widget.splashRadius * progress;
      if (_bubbleRadius == widget.splashRadius) {
        _bubbleRadius = 0;
      }
      _iconScale = progress < 0.5
          ? 1 + progress * widget.scaleFactor
          : 1 + widget.scaleFactor - progress * widget.scaleFactor;
    });
  }

  @override
  void dispose() {
    _bubble
      ..removeListener(_onBubbleTick)
      ..dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _RoundedRectangleClipper clipper = _RoundedRectangleClipper(
      widget.cornerRadius ?? 0,
    );
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: PhysicalShape(
        elevation: widget.elevation ?? 8,
        color: Colors.transparent,
        clipper: clipper,
        child: AroundCustomPainter(
          clipper: clipper,
          shadow: widget.shadow,
          borderColor: widget.borderColor ?? Colors.transparent,
          borderWidth: widget.borderWidth ?? 2,
          child: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: widget.backgroundColor ?? Colors.white,
      child: SafeArea(
        left: widget.safeAreaValues.left,
        top: widget.safeAreaValues.top,
        right: widget.safeAreaValues.right,
        bottom: widget.safeAreaValues.bottom,
        child: widget.blurEffect
            ? ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                  child: _buildBody(),
                ),
              )
            : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: widget.height ?? kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        gradient: widget.backgroundGradient,
      ),
      child: Row(
        mainAxisAlignment: widget.navigationBarType == NavigationBarType.center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final int itemCount = widget.itemCount ?? widget.icons!.length;
    final bool centered = widget.navigationBarType == NavigationBarType.center;

    final List<Widget> items = <Widget>[];
    if (centered) items.add(_FlexibleOuterSpace(flex: widget.outerFlex));
    for (int i = 0; i < itemCount; i++) {
      final bool isActive = i == widget.activeIndex;
      items.add(
        NavigationBarItem(
          isActive: isActive,
          bubbleRadius: _bubbleRadius,
          maxBubbleRadius: widget.splashRadius,
          // Passing a null splashColor used to reach the painter as null,
          // which painted the splash white - invisible on the default
          // background - rather than the documented purple.
          bubbleColor:
              widget.splashColor ??
              AwesomeFloatingBottomNavigation._defaultSplashColor,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          iconData: widget.icons?.elementAt(i),
          iconScale: _iconScale,
          iconSize: widget.iconSize,
          onTap: () => widget.onTap(i),
          itemFlex: centered ? widget.itemFlex : null,
          semanticLabel: widget.semanticLabels?.elementAt(i),
          child: widget.tabBuilder?.call(i, isActive),
        ),
      );
    }
    if (centered) items.add(_FlexibleOuterSpace(flex: widget.outerFlex));
    return items;
  }
}

class _FlexibleOuterSpace extends StatelessWidget {
  const _FlexibleOuterSpace({required this.flex});

  final int flex;

  @override
  Widget build(BuildContext context) =>
      Flexible(flex: flex, child: const SizedBox.shrink());
}

class _RoundedRectangleClipper extends CustomClipper<Path> {
  const _RoundedRectangleClipper(this.borderRadius);

  final double borderRadius;

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, borderRadius)
      ..lineTo(size.width, size.height - borderRadius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - borderRadius,
        size.height,
      )
      ..lineTo(borderRadius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - borderRadius)
      ..lineTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0);
  }

  @override
  bool shouldReclip(_RoundedRectangleClipper oldClipper) =>
      oldClipper.borderRadius != borderRadius;
}
