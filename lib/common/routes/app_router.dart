import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/page_transitions.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/auth/screens/auth_screen.dart';
import 'package:lokapandu/presentation/auth/screens/splash_screen.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_preview_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_detail_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          pageBuilder: (context, state) => PageTransitions.noTransition(
            const SplashScreen(),
            name: 'splash',
          ),
        ),
        GoRoute(
          path: '/auth',
          name: 'auth',
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            const AuthScreen(),
            name: 'auth',
            duration: const Duration(milliseconds: 500),
          ),
        ),
        GoRoute(
          path: '/tourism_spot',
          name: 'tourism_spot',
          pageBuilder: (context, state) =>
              PageTransitions.slideAndFadeTransition(
                const TourismSpotPage(),
                name: 'tourism_spot',
                duration: const Duration(milliseconds: 400),
              ),
          routes: [
            GoRoute(
              path: 'preview/:id',
              name: 'tourism_spot_preview',
              pageBuilder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return PageTransitions.slideFromRightTransition(
                  TourismSpotPreviewPage(id: id),
                  name: 'tourism_spot_preview',
                  duration: const Duration(milliseconds: 350),
                );
              },
            ),
            GoRoute(
              path: 'detail',
              name: 'tourism_spot_detail',
              pageBuilder: (context, state) {
                final tour = state.extra as TourismSpot;
                return PageTransitions.scaleTransition(
                  TourismSpotDetailPage(tour: tour),
                  name: 'tourism_spot_detail',
                  duration: const Duration(milliseconds: 400),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
