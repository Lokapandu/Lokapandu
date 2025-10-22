import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TextField(
      onChanged: onChanged,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: 'Cari destinasi wisata',
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
