import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/page_transitions.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/features/ai_chat/screens/ai_chat_screen.dart';
import 'package:lokapandu/features/bookmark/screens/bookmark_screen.dart';
import 'package:lokapandu/features/plan/screens/note_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/plan_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_plan_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_search_sceen.dart';
import 'package:lokapandu/features/settings/screens/settings_screen.dart';
import 'package:lokapandu/presentation/auth/screens/auth_screen.dart';
import 'package:lokapandu/presentation/auth/screens/splash_screen.dart';
import 'package:lokapandu/presentation/home/screens/home_content.dart';
import 'package:lokapandu/presentation/home/screens/home_screen.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_detail_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_preview_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeRoute().path,
      routes: [
        GoRoute(
          path: SplashRoute().path,
          name: SplashRoute().routeName,
          builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
          path: AuthRoute().path,
          name: AuthRoute().routeName,
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            const AuthScreen(),
            name: AuthRoute().routeName,
          ),
        ),

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
              path: HomeRoute().path,
              name: HomeRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const HomeContent(),
                name: HomeRoute().routeName,
              ),
            ),
            GoRoute(
              path: TourismSpotRoute().path,
              name: TourismSpotRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const TourismSpotPage(),
                name: TourismSpotRoute().routeName,
              ),
            ),
            GoRoute(
              path: PlanRoute().path,
              name: PlanRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const PlanScreen(),
                name: PlanRoute().routeName,
              ),
            ),
            GoRoute(
              path: SettingsRoute().path,
              name: SettingsRoute().routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const SettingsScreen(),
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
              TourismSpotPreviewPage(id: id),
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
              TourismSpotDetailPage(tour: tour),
              name: TourismSpotDetailRoute().routeName,
            );
          },
        ),
        GoRoute(
          path: AiChatRoute().path,
          name: AiChatRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const AiChatScreen(),
                name: AiChatRoute().routeName,
              ),
        ),
        GoRoute(
          path: BookmarksRoute().path,
          name: BookmarksRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromRightTransition(
                const BookmarkScreen(),
                name: BookmarksRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanSearchRoute().path,
          name: PlanSearchRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const TourSearchScreen(),
                name: PlanSearchRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanAddRoute().path,
          name: PlanAddRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const TourPlanEditorScreen(),
                name: PlanAddRoute().routeName,
              ),
        ),
        GoRoute(
          path: PlanAddNoteRoute().path,
          name: PlanAddNoteRoute().routeName,
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const NoteEditorScreen(),
                name: PlanAddNoteRoute().routeName,
              ),
        ),
      ],
    );
  }
}
