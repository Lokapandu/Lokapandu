import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lokapandu/app.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:lokapandu/env/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lokapandu/common/services/crashlytics_service.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_notifier.dart';
import 'package:lokapandu/presentation/settings/providers/package_info_notifier.dart';
import 'package:lokapandu/presentation/settings/providers/user_settings_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';
import 'package:lokapandu/presentation/settings/providers/analytics_provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_calculation_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart' as di;
import 'package:sqflite/sqflite.dart';
import 'package:lokapandu/common/services/notification_service.dart';
import 'package:lokapandu/presentation/settings/providers/notification_settings_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService().initialize();

  // Initialize Firebase Crashlytics
  await CrashlyticsService.initialize();

  // Set up global error handlers
  FlutterError.onError = (errorDetails) {
    CrashlyticsService.recordFlutterError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    CrashlyticsService.recordError(error, stack, fatal: true);
    return true;
  };

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);

  // Un-comment when needed, This Repository refers to Brick's repository
  await Repository.configure(
    supabaseAnonKey: Env.supabaseKey,
    supabaseUrl: Env.supabaseUrl,
    databaseFactory: databaseFactory,
  );
  await Repository().initialize();

  await di.initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AppHeaderNotifier>()..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TourismSpotNotifier>(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<BookmarkProvider>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<TourismSpotDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TourismSpotCalculationNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ThemeProvider>()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AnalyticsProvider>()..load(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<AuthNotifier>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<PackageInfoNotifier>()..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserSettingsNotifier>()..init(),
        ),
        ChangeNotifierProvider(create: (_) => NotificationSettingsNotifier()),
      ],
      child: const App(),
    ),
  );
}
