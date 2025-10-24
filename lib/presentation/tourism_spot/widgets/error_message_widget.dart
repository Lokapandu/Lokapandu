import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';

class ErrorMessageViewer extends StatelessWidget {
  const ErrorMessageViewer({
    super.key,
    required this.error,
    required this.reload,
  });

  final Failure error;
  final VoidCallback reload;

  String get imagePath => error is ConnectionFailure
      ? 'assets/illustrations/connection-error.webp'
      : 'assets/illustrations/server-error.webp';

  void handlePressed() {
    if (error is ConnectionFailure) {
      if (OpenSettingsPlus.shared is OpenSettingsPlusAndroid) {
        (OpenSettingsPlus.shared as OpenSettingsPlusAndroid).wifi();
      }
    } else {
      reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 300,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.error_outline,
              size: 100,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            error.message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: handlePressed,
            child: Text(error is ConnectionFailure
                ? 'Coba lagi'
                : 'Refresh'),
          ),
        ],
      ),
    );
  }
}
