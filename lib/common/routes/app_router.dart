
import 'package:go_router/go_router.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/features/home/screens/home_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_search_sceen.dart';
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
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/home',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeContent(),
            ),
            GoRoute(
              path: '/tourism_spot',
              builder: (context, state) => const TourismSpotPage(),
            ),
            GoRoute(
              path: '/plan',
              builder: (context, state) => const PlanScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),

        // RUTE FULLSCREEN
        GoRoute(
          path: '/tourism_spot/preview/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return TourismSpotPreviewPage(id: id);
          },
        ),
        GoRoute(
          path: '/tour-detail',
          builder: (context, state) {
            final tour = state.extra as TourismSpot;
            return TourismSpotDetailPage(tour: tour);
          },
        ),
        GoRoute(
          path: '/ai_chat',
          builder: (context, state) => const AiChatScreen(),
        ),
        GoRoute(
          path: '/bookmarks',
          builder: (context, state) => const BookmarkScreen(),
        ),
        GoRoute(
          path: '/plan/add-tour',
          builder: (context, state) => const TourPlanEditorScreen(),
        ),
        GoRoute(
          path: '/plan/add-note',
          builder: (context, state) => const NoteEditorScreen(),
        ),
        GoRoute(
          path: '/plan/search-tour',
          builder: (context, state) => const TourSearchScreen(),
        ),
      ],
    );
  }
}
