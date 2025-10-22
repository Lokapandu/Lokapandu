import 'package:flutter/material.dart';

import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/common/config/app_locale.dart';
import 'package:lokapandu/common/routes/app_router.dart';
import 'package:lokapandu/common/themes/theme.dart';
import 'package:lokapandu/common/themes/util.dart';
import 'package:lokapandu/presentation/common/widgets/error_boundary.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  static final _router = AppRouter.createRouter();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
          countryCode: 'US',
          fontFamily: 'Font EN',
        ),
        const MapLocale(
          'id',
          AppLocale.ID,
          countryCode: 'ID',
          fontFamily: 'Font ID',
        ),
      ],
      initLanguageCode: 'en',
    );
    super.initState();
  }

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
            routerConfig: App._router,
            builder: (context, child) {
              return ErrorBoundary(
                errorContext: 'App Builder',
                child: child ?? const SizedBox.shrink(),
              );
            },
            supportedLocales: _localization.supportedLocales,
            localizationsDelegates: _localization.localizationsDelegates,
          );
        },
      ),
    );
  }
}
