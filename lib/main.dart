import 'package:flutter/material.dart';
import 'package:lokapandu/app.dart';
import 'package:lokapandu/env/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lokapandu/presentation/provider/counter_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<CounterNotifier>()),
      ],
      child: const App(),
    ),
  );
}
