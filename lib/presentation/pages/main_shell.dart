import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/infrastructure/seeds/data_seeder.dart';
import 'package:tag4u/presentation/pages/friends_page.dart';
import 'package:tag4u/presentation/pages/match_page.dart';
import 'package:tag4u/presentation/pages/profile_page.dart';
import 'package:tag4u/presentation/pages/tag_page.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    ref.read(dataSeedProvider);
    // Ensure self profile is created on first launch.
    ref.read(selfPersonProvider);
  }

  static const _pages = <Widget>[
    ProfilePage(),
    FriendsPage(),
    MatchPage(),
    TagPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: '好友',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: '匹配',
          ),
          NavigationDestination(
            icon: Icon(Icons.label_outline),
            selectedIcon: Icon(Icons.label),
            label: 'Tag',
          ),
        ],
      ),
    );
  }
}
