import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_preview_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_detail_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/tourism_spot',
      routes: [
        GoRoute(
          path: '/tourism_spot',
          builder: (context, state) => const TourismSpotPage(),
          routes: [
            GoRoute(
              path: 'preview/:id',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return TourismSpotPreviewPage(id: id);
              },
            ),
            GoRoute(
              path: '/detail',
              builder: (context, state) {
                final tour =
                    state.extra as TourismSpot;
                return TourismSpotDetailPage(tour: tour);
              },
            ),
          ],
        ),
      ],
    );
  }
}
