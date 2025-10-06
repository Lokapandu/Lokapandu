import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/page_transitions.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/home/screens/home_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: TourismSpotRoute().path,
      routes: [
        GoRoute(
          path: SplashRoute().path,
          name: SplashRoute().routeName,
          builder: (context, state) => SplashRoute().pageComponent(),
        ),

        GoRoute(
          path: AuthRoute().path,
          name: AuthRoute().routeName,
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            AuthRoute().pageComponent(),
            name: AuthRoute().routeName,
          ),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
              path: HomeRoute().path,
              name: HomeRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                HomeRoute().pageComponent(),
                name: HomeRoute().routeName,
              ),
            ),
            GoRoute(
              path: TourismSpotRoute().path,
              name: TourismSpotRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                TourismSpotRoute().pageComponent(),
                name: TourismSpotRoute().routeName,
              ),
            ),
            GoRoute(
              path: PlanRoute().path,
              name: PlanRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                PlanRoute().pageComponent(),
                name: PlanRoute().routeName,
              ),
            ),
            GoRoute(
              path: SettingsRoute().path,
              name: SettingsRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                SettingsRoute().pageComponent(),
                name: SettingsRoute().routeName,
              ),
            ),
          ],
        ),

        GoRoute(
          path: TourismSpotPreviewRoute().path,
          name: TourismSpotPreviewRoute().routeName,
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return PageTransitions.slideFromRightTransition(
              TourismSpotPreviewRoute().pageComponent(arguments: id),
              name: TourismSpotPreviewRoute().routeName,
            );
          },
        ),
        GoRoute(
          path: TourismSpotDetailRoute().path,
          name: TourismSpotDetailRoute().routeName,
          pageBuilder: (context, state) {
            final tour = state.extra as TourismSpot;
            return PageTransitions.scaleTransition(
              TourismSpotDetailRoute().pageComponent(arguments: tour),
              name: TourismSpotDetailRoute().routeName,
            );
          },
        ),
        GoRoute(
          path: AiChatRoute().path,
          name: AiChatRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                AiChatRoute().pageComponent(),
                name: AiChatRoute().routeName,
              ),
        ),
        GoRoute(
          path: BookmarksRoute().path,
          name: BookmarksRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromRightTransition(
                BookmarksRoute().pageComponent(),
                name: BookmarksRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanSearchRoute().path,
          name: PlanSearchRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                PlanSearchRoute().pageComponent(),
                name: PlanSearchRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanAddRoute().path,
          name: PlanAddRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                PlanAddRoute().pageComponent(),
                name: PlanAddRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanAddNoteRoute().path,
          name: PlanAddNoteRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                PlanAddNoteRoute().pageComponent(),
                name: PlanAddNoteRoute().routeName,
              ),
        ),
      ],
    );
  }
}
