import 'package:flutter/material.dart';
import 'package:lokapandu/common/routes/app_router.dart';
import 'package:lokapandu/common/themes/theme.dart';
import 'package:lokapandu/common/themes/util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Open Sans", "Nunito");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'Lokapandu',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: AppRouter.createRouter(),
    );

    // return MaterialApp(
    //   title: 'Lokapandu',
    //   theme: brightness == Brightness.light ? theme.light() : theme.dark(),
    //   home: const PlanScreen(),
    // );
  }
}
