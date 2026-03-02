import 'package:flutter/material.dart';

import 'home_page.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/youtube_drawer.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int selectedIndex = 0;

  final _navKeys = <GlobalKey<NavigatorState>>[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (index == selectedIndex) {
      _navKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => selectedIndex = index);
    }
  }

  Route _route(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  Widget _buildTabNavigator({
    required GlobalKey<NavigatorState> navKey,
    required Widget root,
  }) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (_) => _route(root),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const YoutubeDrawer(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () => debugPrint("Upload video"),
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          _buildTabNavigator(navKey: _navKeys[0], root: const HomePage()),
          _buildTabNavigator(navKey: _navKeys[1], root: const SubscriptionsTab()),
          _buildTabNavigator(navKey: _navKeys[2], root: const LibraryTab()),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}

class SubscriptionsTab extends StatelessWidget {
  const SubscriptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Subscriptions tab (Nested Navigator)'),
    );
  }
}

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Account tab (Nested Navigator)'),
    );
  }
}