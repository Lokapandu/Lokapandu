import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_notifier.dart';
import 'package:provider/provider.dart';
import 'package:iconify_design/iconify_design.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Consumer<AppHeaderNotifier>(
                    builder: (context, notifier, cihld) {
                      return Row(
                        children: [
                          IconifyIcon(
                            icon: 'material-symbols:location-on-rounded',
                            color: theme.colorScheme.primary,
                            size: 16,
                          ),
                          Text(
                            notifier.nowLocation,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Temukan wisata',
                style: theme.textTheme.titleLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Consumer<AppHeaderNotifier>(
              builder: (context, notifier, child) {
                if (notifier.isLoadingWeather &&
                    notifier.currentWeatherData == null) {
                  return Row(
                    children: [
                      IconifyIcon(
                        icon: 'material-symbols:weather-hail-rounded',
                        size: 16,
                      ),
                      Text('Cuacanya...'),
                    ],
                  );
                }

                if (!notifier.isLoadingWeather &&
                    notifier.currentWeatherData == null) {
                  return Row(
                    children: [
                      IconifyIcon(
                        icon: 'material-symbols:cloud-alert-rounded',
                        color: theme.colorScheme.error,
                        size: 16,
                      ),
                      Text('Tdk ad data'),
                    ],
                  );
                }

                return Row(
                  children: [
                    Image.network(
                      'https://${notifier.currentWeatherData!.icon.substring(2)}',
                      width: 16,
                      height: 16,
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            '${notifier.currentWeatherData!.celciusTemperature}°C ',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: notifier.currentWeatherData!.text,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
