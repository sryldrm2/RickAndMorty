import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: Theme.of(context).colorScheme.primary);
            }
            return TextStyle(color: Theme.of(context).colorScheme.tertiary);
          }),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: navigationShell.goBranch,
          destinations: [
            _menuItem(
              context,
              index: 0,
              currentIndex: navigationShell.currentIndex,
              icon: Icons.face,
              label: 'Karakterler',
            ),
            _menuItem(
              context,
              index: 1,
              currentIndex: navigationShell.currentIndex,
              icon: Icons.face,
              label: 'Favoriler',
            ),
            _menuItem(
              context,
              index: 2,
              currentIndex: navigationShell.currentIndex,
              icon: Icons.face,
              label: 'Konumlar',
            ),
            _menuItem(
              context,
              index: 3,
              currentIndex: navigationShell.currentIndex,
              icon: Icons.face,
              label: 'Bölümler',
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color:
            currentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
      ),
      label: label,
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text(
        'Rick and Morty',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
    );
  }
}
