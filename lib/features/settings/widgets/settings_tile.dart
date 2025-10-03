import 'package:flutter/material.dart';

enum TileAction { navigation, toggle }

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final TileAction actionType;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.actionType = TileAction.navigation,
    this.toggleValue = false,
    this.onToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget trailingWidget;
    switch (actionType) {
      case TileAction.toggle:
        trailingWidget = Switch(
          value: toggleValue,
          onChanged: onToggleChanged,
          activeColor: colorScheme.primary,
        );
        break;
      case TileAction.navigation:
        trailingWidget = Icon(Icons.chevron_right, color: colorScheme.outline);
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: colorScheme.primary, size: 28),
      title: Text(title, style: theme.textTheme.titleMedium),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
      ),
      trailing: trailingWidget,
    );
  }
}
