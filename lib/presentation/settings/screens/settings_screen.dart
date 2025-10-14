import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'package:lokapandu/presentation/settings/providers/package_info_notifier.dart';
import 'package:lokapandu/presentation/settings/widgets/user_profile_section.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';
import 'package:lokapandu/presentation/settings/providers/analytics_provider.dart';
import '../widgets/settings_tile.dart';
import 'package:lokapandu/presentation/settings/providers/notification_settings_notifier.dart';

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
          UserProfileHeader(),
          const Divider(height: 48, indent: 24, endIndent: 24),
          _buildSectionTitle(context, 'Preferensi'),
          SettingsTile(
            icon: Icons.bookmark_border,
            title: 'Bookmark',
            subtitle: 'Lihat daftar wisata tersimpan',
            onTap: () => context.push(Routing.bookmarks.fullPath),
          ),
          SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Mode Gelap',
            subtitle: 'Ganti antara tema terang dan gelap',
            trailing: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) =>
                      context.read<ThemeProvider>().toggleTheme(),
                );
              },
            ),
          ),
          SettingsTile(
            icon: Icons.analytics_outlined,
            title: 'Pengumpulan Data Analytics',
            subtitle: 'Izinkan aplikasi mengumpulkan data penggunaan',
            trailing: Consumer<AnalyticsProvider>(
              builder: (context, analyticsProvider, child) {
                return Switch(
                  value: analyticsProvider.analyticsEnabled,
                  onChanged: (value) =>
                      context.read<AnalyticsProvider>().toggleAnalytics(),
                );
              },
            ),
          ),
          Consumer<NotificationSettingsNotifier>(
            builder: (context, notificationNotifier, child) {
              return SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifikasi',
                subtitle: notificationNotifier.isNotificationEnabled
                    ? 'Anda akan menerima informasi terbaru'
                    : 'Anda tidak akan menerima notifikasi',
                trailing: Switch(
                  value: notificationNotifier.isNotificationEnabled,
                  onChanged: (value) {
                    notificationNotifier.setNotificationStatus(value);
                  },
                ),
              );
            },
          ),
          const Divider(height: 48, indent: 24, endIndent: 24),
          _buildSectionTitle(context, 'Lainnya'),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Lihat versi dan informasi aplikasi',
            onTap: () => context.push(Routing.about.fullPath),
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Keluar',
            subtitle: 'Keluar dari akun Anda',
            onTap: () => _showLogoutConfirmation(context),
            iconColor: colorScheme.error,
            titleColor: colorScheme.error,
          ),
          const SizedBox(height: 40),
          Center(
            child: Consumer<PackageInfoNotifier>(
              builder: (context, packageInfoNotifier, child) {
                return Text(
                  'LokaPandu v${packageInfoNotifier.packageInfo?.version ?? '1.0.0'}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
                );
              },
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

  void _showLogoutConfirmation(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Icon(Icons.logout, size: 48, color: colorScheme.error),
              const SizedBox(height: 16),
              Text(
                'Konfirmasi Keluar',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Apakah Anda yakin ingin keluar dari akun Anda?',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Batal', style: textTheme.labelLarge),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async => _performLogout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        foregroundColor: colorScheme.onError,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Keluar',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      await context.read<AuthNotifier>().signOut();
      // Close loading indicator first
      if (context.mounted) {
        Navigator.of(context).pop();
        context.pushReplacementNamed(Routing.auth.routeName);
      }
    } catch (e) {
      // Close loading indicator if still showing
      if (context.mounted) {
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal keluar: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
