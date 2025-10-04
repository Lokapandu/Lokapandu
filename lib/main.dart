import 'package:flutter/material.dart';
import 'package:lokapandu/app.dart';
import 'package:lokapandu/env/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/theme_provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting('id_ID', null);
  // Un-comment when needed, This Repository refers to Brick's repository
  // await Repository.configure(
  //   supabaseAnonKey: Env.supabaseKey,
  //   supabaseUrl: Env.supabaseUrl,
  //   databaseFactory: databaseFactory,
  // );
  // await Repository().initialize();

  await di.initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<TourismSpotNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TourismSpotDetailNotifier>(),
        ),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const App(),
    ),
  );
}
