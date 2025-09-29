import 'package:flutter/material.dart';

enum TileAction { toggle, navigation }

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final TileAction actionType;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionType = TileAction.navigation,
    this.toggleValue,
    this.onToggleChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF008080)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: _buildTrailing(),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  // Helper untuk menentukan widget di sebelah kanan (trailing)
  Widget? _buildTrailing() {
    if (actionType == TileAction.toggle) {
      return Switch(
        value: toggleValue ?? false,
        onChanged: onToggleChanged,
        activeColor: const Color(0xFF008080),
      );
    }
    // Jika tipe-nya navigation atau tidak ada aksi
    return const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey);
  }
}
