import 'package:flutter/material.dart';
import 'package:lokapandu/common/routes/app_router.dart';
import 'package:lokapandu/common/themes/theme.dart';
import 'package:lokapandu/common/themes/util.dart';
import 'package:lokapandu/presentation/common/widgets/error_boundary.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _router = AppRouter.createRouter();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Open Sans", "Nunito");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ErrorBoundary(
      errorContext: 'App Root',
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Lokapandu',
            themeMode: context.watch<ThemeProvider>().themeMode,
            theme: theme.light(),
            darkTheme: theme.dark(),
            routerConfig: _router,
            builder: (context, child) {
              return ErrorBoundary(
                errorContext: 'App Builder',
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
