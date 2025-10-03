import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_notifier.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Consumer<AppHeaderNotifier>(
                builder: (context, notifier, cihld) {
                  return Text(
                    notifier.nowLocation,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                      overflow: TextOverflow.clip,
                    ),
                  );
                },
              ),
              const Spacer(),
              Icon(Icons.wb_sunny, color: theme.colorScheme.tertiary, size: 16),
              const SizedBox(width: 8),
              Text('27° C Cerah', style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Temukan Wisata',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
