import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/eduverse_state.dart';
import 'eduverse_screens.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final pages = [
      const HomeScreen(),
      const CatalogScreen(),
      const ProgressScreen(),
      const CommunityScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[state.selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.selectedIndex,
        onDestinationSelected: (index) =>
            context.read<EduVerseState>().setSelectedIndex(index),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_rounded), label: 'Accueil'),
          NavigationDestination(
              icon: Icon(Icons.explore_rounded), label: 'Catalogue'),
          NavigationDestination(
              icon: Icon(Icons.insights_rounded), label: 'Progression'),
          NavigationDestination(
              icon: Icon(Icons.groups_rounded), label: 'Communauté'),
          NavigationDestination(
              icon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}
