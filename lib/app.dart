import 'package:flutter/material.dart';
import 'package:lokapandu/common/routes/app_router.dart';
import 'package:lokapandu/common/themes/theme.dart';
import 'package:lokapandu/common/themes/util.dart';
import 'package:lokapandu/presentation/common/widgets/error_boundary.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    TextTheme textTheme = createTextTheme(context, "Open Sans", "Nunito");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ErrorBoundary(
      errorContext: 'App Root',
      child: MaterialApp.router(
        title: 'Lokapandu',
        themeMode: themeProvider.themeMode,
        theme: theme.light(),
        darkTheme: theme.dark(),
        routerConfig: AppRouter.createRouter(),

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
