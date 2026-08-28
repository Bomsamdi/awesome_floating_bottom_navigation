import 'package:awesome_floating_bottom_navigation/awesome_floating_bottom_navigation.dart';
import 'package:awesome_floating_bottom_navigation/src/bubble_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const List<IconData> _icons = <IconData>[
  Icons.home,
  Icons.search,
  Icons.person,
];

Widget _host({
  int activeIndex = 0,
  ValueChanged<int>? onTap,
  NavigationBarType type = NavigationBarType.center,
  Color? splashColor,
  List<String>? semanticLabels,
}) => MaterialApp(
  home: Scaffold(
    bottomNavigationBar: AwesomeFloatingBottomNavigation(
      icons: _icons,
      activeIndex: activeIndex,
      onTap: onTap ?? (_) {},
      navigationBarType: type,
      splashColor: splashColor,
      semanticLabels: semanticLabels,
    ),
  ),
);

/// The painters the bar hands to each item, in item order.
List<BubblePainter> _bubblePainters(WidgetTester tester) => tester
    .widgetList<CustomPaint>(find.byType(CustomPaint))
    .map((CustomPaint p) => p.painter)
    .whereType<BubblePainter>()
    .toList();

void main() {
  group('rendering', () {
    testWidgets('renders one item per icon', (WidgetTester tester) async {
      await tester.pumpWidget(_host());

      for (final IconData icon in _icons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('reports the tapped index', (WidgetTester tester) async {
      final List<int> taps = <int>[];
      await tester.pumpWidget(_host(onTap: taps.add));

      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();

      expect(taps, <int>[1]);
    });

    testWidgets('builder constructor renders custom tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AwesomeFloatingBottomNavigation.builder(
              itemCount: 3,
              activeIndex: 0,
              onTap: (_) {},
              tabBuilder: (int index, bool isActive) =>
                  Text('tab $index ${isActive ? 'on' : 'off'}'),
            ),
          ),
        ),
      );

      expect(find.text('tab 0 on'), findsOneWidget);
      expect(find.text('tab 1 off'), findsOneWidget);
      expect(find.text('tab 2 off'), findsOneWidget);
    });

    testWidgets('expand layout stretches items, center layout does not', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_host(type: NavigationBarType.expand));
      expect(find.byType(Expanded), findsNWidgets(_icons.length));

      await tester.pumpWidget(_host());
      expect(find.byType(Expanded), findsNothing);
    });

    testWidgets('does not require a Scaffold ancestor', (
      WidgetTester tester,
    ) async {
      // The state used to call Scaffold.geometryOf(context) for a value it
      // never read, which made the bar unusable outside a Scaffold.
      await tester.pumpWidget(
        MaterialApp(
          home: Align(
            alignment: Alignment.bottomCenter,
            child: AwesomeFloatingBottomNavigation(
              icons: _icons,
              activeIndex: 0,
              onTap: (_) {},
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });
  });

  group('splash animation', () {
    testWidgets('disposes cleanly while the splash is running', (
      WidgetTester tester,
    ) async {
      // Regression: a controller was created on every didUpdateWidget and never
      // disposed, so leaving the tree mid-animation threw
      // "was disposed with an active Ticker".
      await tester.pumpWidget(_host(activeIndex: 0));
      await tester.pumpWidget(_host(activeIndex: 1));
      await tester.pump(const Duration(milliseconds: 50));

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));

      expect(tester.takeException(), isNull);
    });

    testWidgets('runs when the selection changes', (WidgetTester tester) async {
      await tester.pumpWidget(_host(activeIndex: 0));
      expect(
        _bubblePainters(tester).every((BubblePainter p) => p.bubbleRadius == 0),
        isTrue,
      );

      await tester.pumpWidget(_host(activeIndex: 1));
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        _bubblePainters(tester).any((BubblePainter p) => p.bubbleRadius > 0),
        isTrue,
      );

      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('does not run when an unrelated rebuild happens', (
      WidgetTester tester,
    ) async {
      // The guard on activeIndex used to be commented out, so the splash
      // replayed whenever anything above the bar rebuilt.
      await tester.pumpWidget(_host(activeIndex: 0));

      for (int i = 0; i < 5; i++) {
        await tester.pumpWidget(_host(activeIndex: 0));
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _bubblePainters(
            tester,
          ).every((BubblePainter p) => p.bubbleRadius == 0),
          isTrue,
          reason: 'rebuild $i restarted the splash animation',
        );
      }
    });

    testWidgets('defaults to a visible purple splash', (
      WidgetTester tester,
    ) async {
      // Regression: the null splashColor reached the painter as null, which
      // painted white - invisible on the default white background.
      await tester.pumpWidget(_host());

      expect(
        _bubblePainters(tester).map((BubblePainter p) => p.bubbleColor),
        everyElement(Colors.purple),
      );
    });

    testWidgets('honours a custom splash color', (WidgetTester tester) async {
      await tester.pumpWidget(_host(splashColor: Colors.green));

      expect(
        _bubblePainters(tester).map((BubblePainter p) => p.bubbleColor),
        everyElement(Colors.green),
      );
    });
  });

  group('accessibility', () {
    testWidgets('exposes each item as a selectable button', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(
          activeIndex: 1,
          semanticLabels: const <String>['Home', 'Search', 'Profile'],
        ),
      );

      expect(find.bySemanticsLabel('Home'), findsOneWidget);
      expect(find.bySemanticsLabel('Profile'), findsOneWidget);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Search')),
        isSemantics(isButton: true, isSelected: true),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Home')),
        isSemantics(isButton: true, isSelected: false),
      );

      handle.dispose();
    });
  });

  group('asserts', () {
    test('rejects fewer than two items', () {
      expect(
        () => AwesomeFloatingBottomNavigation(
          icons: const <IconData>[Icons.home],
          activeIndex: 0,
          onTap: (_) {},
        ),
        throwsAssertionError,
      );
    });

    test('rejects more than five items', () {
      expect(
        () => AwesomeFloatingBottomNavigation(
          icons: const <IconData>[
            Icons.home,
            Icons.search,
            Icons.person,
            Icons.settings,
            Icons.info,
            Icons.star,
          ],
          activeIndex: 0,
          onTap: (_) {},
        ),
        throwsAssertionError,
      );
    });

    test('rejects a semanticLabels list of the wrong length', () {
      expect(
        () => AwesomeFloatingBottomNavigation(
          icons: _icons,
          activeIndex: 0,
          onTap: (_) {},
          semanticLabels: const <String>['only one'],
        ),
        throwsAssertionError,
      );
    });
  });
}
