part of 'awesome_floating_bottom_navigation.dart';

/// Signature for a function that creates a widget for a given index & state.
/// Used by [AwesomeFloatingBottomNavigation.builder].
typedef IndexedWidgetBuilder = Widget Function(int index, bool isActive);

enum NavigationBarType {
  expand,
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
  final IndexedWidgetBuilder? tabBuilder;

  /// Total item count.
  final int? itemCount;

  /// Icon data to render in the tab bar.
  final List<IconData>? icons;

  /// Handler which is passed every updated active index.
  final Function(int) onTap;

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

  static const _defaultSplashRadius = 24.0;

  /// Optional custom tab bar space on left and right of widget. Default is 0.
  final double leftAndRightBonusPadding;

  AwesomeFloatingBottomNavigation._internal({
    Key? key,
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
  })  : assert(icons != null || itemCount != null),
        assert(
          ((itemCount ?? icons!.length) >= 2) &&
              ((itemCount ?? icons!.length) <= 5),
        ),
        super(key: key);

  AwesomeFloatingBottomNavigation({
    Key? key,
    required List<IconData> icons,
    required int activeIndex,
    required Function(int) onTap,
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
        );

  AwesomeFloatingBottomNavigation.builder({
    Key? key,
    required int itemCount,
    required IndexedWidgetBuilder tabBuilder,
    required int activeIndex,
    required Function(int) onTap,
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
        );

  @override
  State<AwesomeFloatingBottomNavigation> createState() =>
      _AwesomeFloationgBottomNavigationBarState();
}

class _AwesomeFloationgBottomNavigationBarState
    extends State<AwesomeFloatingBottomNavigation>
    with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  late AnimationController _bubbleController;

  double _bubbleRadius = 0;
  double _iconScale = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  void didUpdateWidget(AwesomeFloatingBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.activeIndex != oldWidget.activeIndex) {
    //   _startBubbleAnimation();
    // }
    _startBubbleAnimation();
  }

  void _startBubbleAnimation() {
    _bubbleController = AnimationController(
      duration: Duration(milliseconds: widget.splashSpeedInMilliseconds ?? 300),
      vsync: this,
    );

    final bubbleCurve = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.linear,
    );

    Tween<double>(begin: 0, end: 1).animate(bubbleCurve).addListener(() {
      setState(() {
        _bubbleRadius = widget.splashRadius * bubbleCurve.value;
        if (_bubbleRadius == widget.splashRadius) {
          _bubbleRadius = 0;
        }

        if (bubbleCurve.value < 0.5) {
          _iconScale = 1 + bubbleCurve.value * widget.scaleFactor;
        } else {
          _iconScale =
              1 + widget.scaleFactor - bubbleCurve.value * widget.scaleFactor;
        }
      });
    });

    if (_bubbleController.isAnimating) {
      _bubbleController.reset();
    }
    _bubbleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    CustomRoundedRectangleClipper clipper =
        CustomRoundedRectangleClipper(widget.cornerRadius ?? 0);
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
        mainAxisSize: MainAxisSize.max,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final itemCount = widget.itemCount ?? widget.icons!.length;

    final items = <Widget>[];
    if (widget.navigationBarType == NavigationBarType.center) {
      items.add(FlexibleOuterSpace(flex: widget.outerFlex));
    }
    for (var i = 0; i < itemCount; i++) {
      final isActive = i == widget.activeIndex;

      items.add(
        NavigationBarItem(
          isActive: isActive,
          bubbleRadius: _bubbleRadius,
          maxBubbleRadius: widget.splashRadius,
          bubbleColor: widget.splashColor,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          iconData: widget.icons?.elementAt(i),
          iconScale: _iconScale,
          iconSize: widget.iconSize,
          onTap: () => widget.onTap(i),
          itemFlex: widget.navigationBarType == NavigationBarType.center
              ? widget.itemFlex
              : null,
          child: widget.tabBuilder?.call(i, isActive),
        ),
      );
    }
    if (widget.navigationBarType == NavigationBarType.center) {
      items.add(FlexibleOuterSpace(flex: widget.outerFlex));
    }
    return items;
  }
}

class FlexibleOuterSpace extends StatelessWidget {
  final int flex;

  const FlexibleOuterSpace({Key? key, required this.flex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }
}

class CustomRoundedRectangleClipper extends CustomClipper<Path> {
  final double borderRadius;

  CustomRoundedRectangleClipper(this.borderRadius);

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, borderRadius)
      ..lineTo(size.width, size.height - borderRadius)
      ..quadraticBezierTo(
          size.width, size.height, size.width - borderRadius, size.height)
      ..lineTo(borderRadius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - borderRadius)
      ..lineTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomRoundedRectangleClipper oldClipper) => true;
}
