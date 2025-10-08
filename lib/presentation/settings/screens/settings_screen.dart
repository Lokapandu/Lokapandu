import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
        shadowColor: theme.shadowColor.withValues(alpha: .1),
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
          _buildUserProfileHeader(context),
          const Divider(height: 48, indent: 24, endIndent: 24),
          _buildSectionTitle(context, 'Preferensi'),
          SettingsTile(
            icon: Icons.bookmark_border,
            title: 'Bookmark',
            subtitle: 'Lihat daftar wisata tersimpan',
            onTap: () => context.push(Routing.bookmarks.path),
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
                    // FIX: Gunakan context.read di sini
                    context.read<ThemeProvider>().toggleTheme();
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
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Lihat versi dan informasi aplikasi',
            onTap: () {},
          ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              'LokaPandu v1.0.0',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final User? auth = Supabase.instance.client.auth.currentUser;

    final String picture = auth?.userMetadata?['avatar_url'] ?? '';
    final String userName = auth?.userMetadata?['full_name'] ?? 'User';
    final String userEmail = auth?.email ?? 'user@example.com';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          picture.isNotEmpty
              ? CircleAvatar(
                  radius: 32,
                  child: ClipOval(
                    child: Image.network(picture, fit: BoxFit.cover),
                  ),
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    userName.isNotEmpty ? userName[0] : 'U',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
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
