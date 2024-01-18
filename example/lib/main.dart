import 'package:awesome_floating_bottom_navigation/awesome_floating_bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AwesomeFloatingBottomNavigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AwesomeFloatingBottomNavigation Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final iconList = <IconData>[
    Icons.dashboard,
    Icons.search,
    Icons.shopping_bag,
    Icons.qr_code,
    Icons.account_circle
  ];

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageController.jumpToPage(index);
          });
        },
        children: const [
          NavigationScreen(Icons.dashboard),
          NavigationScreen(Icons.search),
          NavigationScreen(Icons.shopping_bag),
          NavigationScreen(Icons.qr_code),
          NavigationScreen(Icons.account_circle),
        ],
      ),
      bottomNavigationBar: AwesomeFloatingBottomNavigation.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.green : Colors.grey;
          return Center(
            child: Icon(
              iconList[index],
              size: 24,
              color: color,
            ),
          );
        },
        backgroundColor: Colors.black87,
        activeIndex:
            pageController.hasClients ? pageController.page?.round() ?? 0 : 0,
        splashColor: Colors.green.shade400,
        splashSpeedInMilliseconds: 300,
        cornerRadius: 32,
        onTap: (index) => setState(() {
          pageController.jumpToPage(index);
        }),
        padding: const EdgeInsets.all(16),
        leftAndRightBonusPadding: 48,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
        navigationBarType: NavigationBarType.center,
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen(this.iconData, {super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          const SizedBox(height: 64),
          Center(
            child: Icon(
              widget.iconData,
              color: Colors.green,
              size: 160,
            ),
          ),
        ],
      ),
    );
  }
}
