import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/settings/providers/user_settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Consumer<UserSettingsNotifier>(
        builder: (context, userSettingsNotifier, child) {
          final User? user = userSettingsNotifier.user;
          final String userName = user?.userMetadata?['full_name'] ?? '';
          final String userEmail = user?.email ?? 'user@example.com';

          return Row(
            children: [
              CircleAvatar(
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
          );
        },
      ),
    );
  }
}
