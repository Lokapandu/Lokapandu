import 'package:flutter/material.dart';
import 'package:lokapandu/common/routes/app_router.dart';
import 'package:lokapandu/common/themes/theme.dart';
import 'package:lokapandu/common/themes/util.dart';
import 'package:lokapandu/presentation/common/widgets/error_boundary.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Open Sans", "Nunito");

    MaterialTheme theme = MaterialTheme(textTheme);

    return ErrorBoundary(
      errorContext: 'App Root',
      child: MaterialApp.router(
        title: 'Lokapandu',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routerConfig: AppRouter.createRouter(),
        // Tambahkan navigation observer untuk tracking
        builder: (context, child) {
          return ErrorBoundary(
            errorContext: 'App Builder',
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
