import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/page_transitions.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/features/plan/screens/tour_search_sceen.dart';

// Import semua halaman Anda
import 'package:lokapandu/presentation/auth/screens/splash_screen.dart';
import 'package:lokapandu/presentation/auth/screens/auth_screen.dart';
import 'package:lokapandu/features/home/screens/home_screen.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_preview_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_detail_page.dart';
import 'package:lokapandu/features/plan/screens/plan_screen.dart';
import 'package:lokapandu/features/settings/screens/settings_screen.dart';
import 'package:lokapandu/features/ai_chat/screens/ai_chat_screen.dart';
import 'package:lokapandu/features/bookmark/screens/bookmark_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_plan_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/note_editor_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
          path: '/auth',
          name: 'auth',
          pageBuilder: (context, state) =>
              PageTransitions.fadeTransition(const AuthScreen(), name: 'auth'),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const HomeContent(),
                name: 'home',
              ),
            ),
            GoRoute(
              path: '/tourism_spot',
              name: 'tourism_spot',
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const TourismSpotPage(),
                name: 'tourism_spot',
              ),
            ),
            GoRoute(
              path: '/plan',
              name: 'plan',
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const PlanScreen(),
                name: 'plan',
              ),
            ),
            GoRoute(
              path: '/settings',
              name: 'settings',
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const SettingsScreen(),
                name: 'settings',
              ),
            ),
          ],
        ),

        GoRoute(
          path: '/tourism_spot/preview/:id',
          name: 'tourism_spot_preview',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return PageTransitions.slideFromRightTransition(
              TourismSpotPreviewPage(id: id),
              name: 'tourism_spot_preview',
            );
          },
        ),
        GoRoute(
          path: '/tourism_spot/detail',
          name: 'tourism_spot_detail',
          pageBuilder: (context, state) {
            final tour = state.extra as TourismSpot;
            return PageTransitions.scaleTransition(
              TourismSpotDetailPage(tour: tour),
              name: 'tourism_spot_detail',
            );
          },
        ),
        GoRoute(
          path: '/ai_chat',
          name: 'ai_chat',
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const AiChatScreen(),
                name: 'ai_chat',
              ),
        ),
        GoRoute(
          path: '/bookmarks',
          name: 'bookmarks',
          pageBuilder: (context, state) =>
              PageTransitions.slideFromRightTransition(
                const BookmarkScreen(),
                name: 'bookmarks',
              ),
        ),
        GoRoute(
          path: '/plan/search-tour',
          name: 'search_tour',
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const TourSearchScreen(),
                name: 'search_tour',
              ),
        ),
        GoRoute(
          path: '/plan/add-tour',
          name: 'add_tour',
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const TourPlanEditorScreen(),
                name: 'add_tour',
              ),
        ),
        GoRoute(
          path: '/plan/add-note',
          name: 'add_note',
          pageBuilder: (context, state) =>
              PageTransitions.slideFromBottomTransition(
                const NoteEditorScreen(),
                name: 'add_note',
              ),
        ),
      ],
    );
  }
}
