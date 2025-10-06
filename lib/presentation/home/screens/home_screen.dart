import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/home/models/navigation_item_model.dart';
import 'package:lokapandu/presentation/home/widgets/home_widgets.dart';
import 'package:iconify_design/iconify_design.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedIndex = navigationItems
        .map(
          (item) =>
              GoRouterState.of(context).matchedLocation.startsWith(item.path),
        )
        .toList()
        .asMap()
        .entries
        .firstWhere(
          (entry) => entry.value,
          orElse: () => const MapEntry(0, false),
        )
        .key;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 25),
        child: InkWell(
          onTap: () => context.goNamed('ai_chat'),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: null,
                shape: const CircleBorder(),
                backgroundColor: colorScheme.primary,
                elevation: 4.0,
                child: IconifyIcon(
                  icon: 'ri:chat-ai-fill',
                  size: 32,
                  color: Theme.of(context).colorScheme.surface,
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
      ),
      bottomNavigationBar: buildBottomNavigation(context, selectedIndex),
    );
  }
}
