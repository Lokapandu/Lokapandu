import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/crashlytics_service.dart';

/// Widget untuk menangkap error yang terjadi di widget tree
/// dan melaporkannya ke Crashlytics
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallbackWidget;
  final String? errorContext;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallbackWidget,
    this.errorContext,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallbackWidget ?? _buildDefaultErrorWidget();
    }

    return widget.child;
  }

  @override
  void initState() {
    super.initState();

    // Set up error handling
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Log error ke Crashlytics
      CrashlyticsService.recordFlutterError(details);

      // Set custom context jika ada
      if (widget.errorContext != null) {
        CrashlyticsService.setCustomKey('error_context', widget.errorContext!);
      }

      // Update state jika widget masih mounted
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
      }

      // Return fallback widget atau default error widget
      return widget.fallbackWidget ?? _buildDefaultErrorWidget();
    };
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Oops! Terjadi kesalahan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tim kami telah diberitahu tentang masalah ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasError = false;
              });
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}

/// Extension untuk memudahkan wrapping widget dengan ErrorBoundary
extension ErrorBoundaryExtension on Widget {
  Widget withErrorBoundary({Widget? fallbackWidget, String? errorContext}) {
    return ErrorBoundary(
      fallbackWidget: fallbackWidget,
      errorContext: errorContext,
      child: this,
    );
  }
}
