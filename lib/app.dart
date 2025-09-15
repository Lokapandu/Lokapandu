import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/pages/home_page.dart';
import 'package:lokapandu/presentation/provider/counter_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
