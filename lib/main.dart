import 'package:flutter/material.dart';
import 'package:lokapandu/app.dart';
import 'package:lokapandu/env/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      ],
      child: const App(),
    ),
  );
}
