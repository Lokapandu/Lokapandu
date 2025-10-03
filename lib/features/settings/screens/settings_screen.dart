import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/settings_tile.dart'; 

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil theme dan colorScheme yang didefinisikan di MaterialTheme Anda
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Mendengarkan perubahan tema dari ThemeProvider
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan', style: theme.textTheme.titleLarge),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifikasi',
            subtitle: 'Dapatkan notifikasi mengenai wisata yang menarik.',
            actionType: TileAction.toggle,
            toggleValue: true, 
            onToggleChanged: (value) {
              // TODO: Implementasi logika notifikasi
            },
          ),
          Divider(color: colorScheme.outlineVariant, thickness: 1, height: 32),
          SettingsTile(
            icon: Icons.palette_outlined,
            title: 'Tema Gelap',
            subtitle: 'Ubah tema sesuai kebutuhan.',
            actionType: TileAction.toggle,
            toggleValue: themeProvider.themeMode == ThemeMode.dark,
            onToggleChanged: (value) {
              context.read<ThemeProvider>().toggleTheme(value);
            },
          ),
          Divider(color: colorScheme.outlineVariant, thickness: 1, height: 32),
          SettingsTile(
            icon: Icons.bookmark_border,
            title: 'Bookmark',
            subtitle: 'Wisata tersimpan',
            onTap: () {
              context.push('/bookmarks');
            },
          ),
          Divider(color: colorScheme.outlineVariant, thickness: 1, height: 32),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Pengembang',
            subtitle: 'Lokapandu by BEKUP B25-PG008 Team',
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
