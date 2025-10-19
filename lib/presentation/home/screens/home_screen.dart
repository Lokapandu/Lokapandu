import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:iconify_design/iconify_design.dart';

import 'package:lokapandu/presentation/home/models/navigation_item_model.dart';
import 'package:lokapandu/presentation/home/widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouterState.of(context).fullPath;
    final isNavigationPane = navigationItems.any(
      (element) => fullPath == element.path,
    );
    final matchedLocation = GoRouterState.of(context).matchedLocation;
    final selectedIndex = navigationItems
        .map((item) => matchedLocation == item.path)
        .toList()
        .asMap()
        .entries
        .firstWhere(
          (entry) => entry.value,
          orElse: () => const MapEntry(0, false),
        )
        .key;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isNavigationPane
          ? _buildAIChatButton(context)
          : null,
      bottomNavigationBar: isNavigationPane
          ? LokapanduBottomNavigation(selectedIndex: selectedIndex)
          : null,
    );
  }

  Widget _buildAIChatButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Transform.translate(
      offset: const Offset(0, 25),
      child: InkWell(
        onTap: () => context.pushNamed('ai_chat'),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FloatingActionButton(
              onPressed: null,
              shape: CircleBorder(),
              elevation: 4.0,
              child: IconifyIcon(
                icon: 'ri:chat-ai-fill',
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'AI Chat',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
