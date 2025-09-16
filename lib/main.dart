import 'package:flutter/material.dart';
import 'package:lokapandu/app.dart';
import 'package:lokapandu/env/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseKey,
  );
  
  runApp(const App());
}
