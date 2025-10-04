import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/theme_provider.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withOpacity(0.1),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Pengaturan',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        children: [
          _buildSectionTitle(context, 'Preferensi'),
          SettingsTile(
            icon: Icons.bookmark_border,
            title: 'Bookmark',
            subtitle: 'Lihat daftar wisata tersimpan',
            onTap: () => context.push('/bookmarks'),
          ),
          SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Mode Gelap',
            subtitle: 'Ganti antara tema terang dan gelap',
            trailing: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
          const Divider(height: 48, indent: 24, endIndent: 24),
          _buildSectionTitle(context, 'Lainnya'),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Bantuan & Dukungan',
            subtitle: 'Hubungi kami jika ada masalah',
            onTap: () {
              // TODO: Navigasi ke halaman bantuan
            },
          ),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Lihat versi dan informasi aplikasi',
            onTap: () {
              // TODO: Navigasi ke halaman tentang
            },
          ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              'LokaPandu v1.0.0',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}