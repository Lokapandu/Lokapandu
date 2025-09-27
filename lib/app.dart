import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokapandu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TourismSpotPage(),
    );
  }
}
