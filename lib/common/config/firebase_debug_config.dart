import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

/// Firebase Analytics Debug Configuration
/// Handles platform-specific debug mode setup for Firebase Analytics
class FirebaseDebugConfig {
  static const String _debugTag = 'FirebaseDebugConfig';
  static bool _isDebugModeEnabled = false;
  static String? _packageName;

  /// Initialize debug configuration
  static Future<void> initialize() async {
    if (kDebugMode) {
      await _setupDebugMode();
    }
  }

  /// Setup debug mode for Firebase Analytics
  static Future<void> _setupDebugMode() async {
    try {
      _packageName = await _getPackageName();

      if (Platform.isAndroid) {
        await _enableAndroidDebugMode();
      } else if (Platform.isIOS) {
        await _enableIOSDebugMode();
      }

      _isDebugModeEnabled = true;

      developer.log(
        'Firebase Analytics debug mode enabled for $_packageName',
        name: _debugTag,
      );
    } catch (e) {
      developer.log(
        'Failed to enable Firebase Analytics debug mode: $e',
        name: _debugTag,
        level: 1000, // Error level
      );
    }
  }

  /// Enable debug mode for Android
  static Future<void> _enableAndroidDebugMode() async {
    if (!Platform.isAndroid || _packageName == null) return;

    try {
      // Use method channel to enable debug mode
      const platform = MethodChannel('firebase_analytics_debug');

      try {
        await platform.invokeMethod('enableDebugMode', {
          'packageName': _packageName,
        });

        developer.log(
          'Android debug mode enabled via method channel',
          name: _debugTag,
        );
      } catch (e) {
        // Fallback: Log instructions for manual setup
        developer.log(
          'Method channel not available. To enable debug mode manually, run:',
          name: _debugTag,
        );
        developer.log(
          'adb shell setprop debug.firebase.analytics.app $_packageName',
          name: _debugTag,
        );
        developer.log(
          'Then restart the app to see events in DebugView',
          name: _debugTag,
        );
      }
    } catch (e) {
      developer.log(
        'Error enabling Android debug mode: $e',
        name: _debugTag,
        level: 1000,
      );
    }
  }

  /// Enable debug mode for iOS
  static Future<void> _enableIOSDebugMode() async {
    if (!Platform.isIOS) return;

    try {
      // Use method channel to enable debug mode
      const platform = MethodChannel('firebase_analytics_debug');

      try {
        await platform.invokeMethod('enableDebugMode');

        developer.log(
          'iOS debug mode enabled via method channel',
          name: _debugTag,
        );
      } catch (e) {
        // Fallback: Log instructions for manual setup
        developer.log(
          'Method channel not available. To enable debug mode manually:',
          name: _debugTag,
        );
        developer.log(
          '1. In Xcode, edit the scheme for your app',
          name: _debugTag,
        );
        developer.log(
          '2. Add -FIRDebugEnabled to Arguments Passed On Launch',
          name: _debugTag,
        );
        developer.log(
          'Or use UserDefaults workaround in AppDelegate',
          name: _debugTag,
        );
      }
    } catch (e) {
      developer.log(
        'Error enabling iOS debug mode: $e',
        name: _debugTag,
        level: 1000,
      );
    }
  }

  /// Get package name for the current platform
  static Future<String?> _getPackageName() async {
    try {
      const platform = MethodChannel('app_info');
      final packageName = await platform.invokeMethod('getPackageName');
      return packageName as String?;
    } catch (e) {
      // Fallback package names based on platform
      if (Platform.isAndroid) {
        return 'com.example.lokapandu'; // Default Android package
      } else if (Platform.isIOS) {
        return 'com.example.lokapandu'; // Default iOS bundle ID
      }
      return null;
    }
  }

  /// Check if debug mode is enabled
  static bool get isDebugModeEnabled => _isDebugModeEnabled && kDebugMode;

  /// Get package name
  static String? get packageName => _packageName;

  /// Get debug view URL for Firebase console
  static String? get debugViewUrl {
    if (_packageName == null) return null;

    // This would be the Firebase console URL for DebugView
    // Replace PROJECT_ID with actual Firebase project ID
    return 'https://console.firebase.google.com/project/lokapandu-29bc5/analytics/debugview';
  }

  /// Print debug configuration info
  static void printDebugInfo() {
    if (!kDebugMode) return;

    developer.log(
      '=== Firebase Analytics Debug Configuration ===',
      name: _debugTag,
    );
    developer.log('Debug Mode Enabled: $isDebugModeEnabled', name: _debugTag);
    developer.log('Package Name: $_packageName', name: _debugTag);
    developer.log('Platform: ${Platform.operatingSystem}', name: _debugTag);

    if (Platform.isAndroid) {
      developer.log('Android Debug Command:', name: _debugTag);
      developer.log(
        'adb shell setprop debug.firebase.analytics.app $_packageName',
        name: _debugTag,
      );
    } else if (Platform.isIOS) {
      developer.log('iOS Debug Setup:', name: _debugTag);
      developer.log(
        'Add -FIRDebugEnabled to Xcode scheme arguments',
        name: _debugTag,
      );
    }

    if (debugViewUrl != null) {
      developer.log('DebugView URL: $debugViewUrl', name: _debugTag);
    }

    developer.log('=== End Debug Configuration ===', name: _debugTag);
  }

  /// Manual debug mode instructions
  static void printManualSetupInstructions() {
    if (!kDebugMode) return;

    developer.log(
      '=== Manual Firebase Analytics Debug Setup ===',
      name: _debugTag,
    );

    if (Platform.isAndroid) {
      developer.log('For Android:', name: _debugTag);
      developer.log('1. Connect your device via USB', name: _debugTag);
      developer.log('2. Enable USB debugging', name: _debugTag);
      developer.log(
        '3. Run: adb shell setprop debug.firebase.analytics.app $_packageName',
        name: _debugTag,
      );
      developer.log('4. Restart the app', name: _debugTag);
      developer.log(
        '5. Open Firebase Console > Analytics > DebugView',
        name: _debugTag,
      );
    } else if (Platform.isIOS) {
      developer.log('For iOS:', name: _debugTag);
      developer.log('1. Open your project in Xcode', name: _debugTag);
      developer.log('2. Select your app scheme', name: _debugTag);
      developer.log('3. Edit Scheme > Run > Arguments', name: _debugTag);
      developer.log(
        '4. Add -FIRDebugEnabled to "Arguments Passed On Launch"',
        name: _debugTag,
      );
      developer.log('5. Run the app from Xcode', name: _debugTag);
      developer.log(
        '6. Open Firebase Console > Analytics > DebugView',
        name: _debugTag,
      );
      developer.log('', name: _debugTag);
      developer.log('Alternative for Flutter iOS:', name: _debugTag);
      developer.log(
        'Add to AppDelegate.swift in didFinishLaunchingWithOptions:',
        name: _debugTag,
      );
      developer.log(
        'UserDefaults.standard.set(true, forKey: "FIRDebugEnabled")',
        name: _debugTag,
      );
    }

    developer.log('=== End Manual Setup Instructions ===', name: _debugTag);
  }
}

/// Method channel handler for native debug configuration
class FirebaseDebugMethodChannel {
  static const MethodChannel _channel = MethodChannel(
    'firebase_analytics_debug',
  );

  /// Register method channel handlers
  static void registerHandlers() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Handle method calls from native side
  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onDebugModeEnabled':
        developer.log(
          'Debug mode enabled from native side',
          name: 'FirebaseDebugMethodChannel',
        );
        return true;
      case 'onDebugModeError':
        final error = call.arguments as String?;
        developer.log(
          'Debug mode error from native side: $error',
          name: 'FirebaseDebugMethodChannel',
          level: 1000,
        );
        return false;
      default:
        throw PlatformException(
          code: 'UNIMPLEMENTED',
          message: 'Method ${call.method} not implemented',
        );
    }
  }
}
