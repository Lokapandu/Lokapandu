import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/page_transitions.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/services/firebase_analytics_service.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/features/ai_chat/screens/ai_chat_screen.dart';
import 'package:lokapandu/features/bookmark/screens/bookmark_screen.dart';
import 'package:lokapandu/features/plan/screens/note_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/plan_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_plan_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_search_sceen.dart';
import 'package:lokapandu/presentation/settings/screens/about_screen.dart';
import 'package:lokapandu/presentation/settings/screens/settings_screen.dart';
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
      initialLocation: Routing.splash.path,
      routes: [
        GoRoute(
          path: Routing.splash.path,
          name: Routing.splash.routeName,
          builder: (context, state) {
            // Track splash screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'splash',
              screenClass: 'SplashScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );

            return const SplashScreen();
          },
        ),

        GoRoute(
          path: Routing.auth.path,
          name: Routing.auth.routeName,
          pageBuilder: (context, state) {
            // Track auth screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'auth',
              screenClass: 'AuthScreen',
              parameters: {
                'entry_time': DateTime.now().toIso8601String(),
                'source': 'splash_screen',
              },
            );
            return PageTransitions.fadeTransition(
              const AuthScreen(),
              name: Routing.auth.routeName,
            );
          },
        ),

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
              path: Routing.home.path,
              name: Routing.home.routeName,
              pageBuilder: (context, state) => PageTransitions.noTransition(
                const HomeContent(),
                name: Routing.home.routeName,
              ),
            ),
            GoRoute(
              path: Routing.tourismSpot.path,
              name: Routing.tourismSpot.routeName,
              pageBuilder: (context, state) {
                // Track tourism spot screen page view
                FirebaseAnalyticsService().trackPageView(
                  screenName: 'tourism_spot',
                  screenClass: 'TourismSpotPage',
                  parameters: {'entry_time': DateTime.now().toIso8601String()},
                );
                return PageTransitions.noTransition(
                  const TourismSpotPage(),
                  name: Routing.tourismSpot.routeName,
                );
              },
              routes: [
                GoRoute(
                  path: Routing.tourismSpotPreview.path,
                  name: Routing.tourismSpotPreview.routeName,
                  pageBuilder: (context, state) {
                    // Track tourism spot preview screen page view
                    FirebaseAnalyticsService().trackPageView(
                      screenName: 'tourism_spot_preview',
                      screenClass: 'TourismSpotPreviewPage',
                      parameters: {
                        'entry_time': DateTime.now().toIso8601String(),
                      },
                    );
                    final id = int.parse(state.pathParameters['id']!);
                    return PageTransitions.slideFromRightTransition(
                      TourismSpotPreviewPage(id: id),
                      name: Routing.tourismSpotPreview.routeName,
                    );
                  },
                ),
                GoRoute(
                  path: Routing.tourismSpotDetail.path,
                  name: Routing.tourismSpotDetail.routeName,
                  pageBuilder: (context, state) {
                    // Track tourism spot detail screen page view
                    FirebaseAnalyticsService().trackPageView(
                      screenName: 'tourism_spot_detail',
                      screenClass: 'TourismSpotDetailPage',
                      parameters: {
                        'entry_time': DateTime.now().toIso8601String(),
                      },
                    );
                    final tour = state.extra as TourismSpot?;
                    if (tour == null) {
                      return MaterialPage<void>(
                        child: Scaffold(
                          body: Center(
                            child: Text(
                              'Tourism spot not found',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      );
                    }

                    return PageTransitions.scaleTransition(
                      TourismSpotDetailPage(tour: tour),
                      name: Routing.tourismSpotDetail.routeName,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: Routing.plan.path,
              name: Routing.plan.routeName,
              pageBuilder: (context, state) {
                // Track plan screen page view
                FirebaseAnalyticsService().trackPageView(
                  screenName: 'plan',
                  screenClass: 'PlanScreen',
                  parameters: {'entry_time': DateTime.now().toIso8601String()},
                );
                return PageTransitions.noTransition(
                  const PlanScreen(),
                  name: Routing.plan.routeName,
                );
              },
            ),
            GoRoute(
              path: Routing.settings.path,
              name: Routing.settings.routeName,
              pageBuilder: (context, state) {
                // Track settings screen page view
                FirebaseAnalyticsService().trackPageView(
                  screenName: 'settings',
                  screenClass: 'SettingsScreen',
                  parameters: {'entry_time': DateTime.now().toIso8601String()},
                );
                return PageTransitions.noTransition(
                  const SettingsScreen(),
                  name: Routing.settings.routeName,
                );
              },
              routes: [
                GoRoute(
                  path: 'about',
                  name: Routing.about.routeName,
                  pageBuilder: (context, state) {
                    // Track about screen page view
                    FirebaseAnalyticsService().trackPageView(
                      screenName: 'about',
                      screenClass: 'AboutScreen',
                      parameters: {
                        'entry_time': DateTime.now().toIso8601String(),
                      },
                    );
                    return PageTransitions.scaleTransition(
                      const AboutScreen(),
                      name: Routing.about.routeName,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        GoRoute(
          path: Routing.aiChat.path,
          name: Routing.aiChat.routeName,
          pageBuilder: (context, state) {
            // Track AI chat screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'ai_chat',
              screenClass: 'AiChatScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );
            return PageTransitions.slideFromBottomTransition(
              const AiChatScreen(),
              name: Routing.aiChat.routeName,
            );
          },
        ),
        GoRoute(
          path: Routing.bookmarks.path,
          name: Routing.bookmarks.routeName,
          pageBuilder: (context, state) {
            // Track bookmarks screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'bookmarks',
              screenClass: 'BookmarkScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );
            return PageTransitions.slideFromRightTransition(
              const BookmarkScreen(),
              name: Routing.bookmarks.routeName,
            );
          },
        ),
        GoRoute(
          path: Routing.planSearch.path,
          name: Routing.planSearch.routeName,
          pageBuilder: (context, state) {
            // Track plan search screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'plan_search',
              screenClass: 'TourSearchScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );
            return PageTransitions.slideFromBottomTransition(
              const TourSearchScreen(),
              name: Routing.planSearch.routeName,
            );
          },
        ),
        GoRoute(
          path: Routing.planAdd.path,
          name: Routing.planAdd.routeName,
          pageBuilder: (context, state) {
            // Track plan add screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'plan_add',
              screenClass: 'TourPlanEditorScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );
            return PageTransitions.slideFromBottomTransition(
              const TourPlanEditorScreen(),
              name: Routing.planAdd.routeName,
            );
          },
        ),
        GoRoute(
          path: Routing.planAddNote.path,
          name: Routing.planAddNote.routeName,
          pageBuilder: (context, state) {
            // Track plan add note screen page view
            FirebaseAnalyticsService().trackPageView(
              screenName: 'plan_add_note',
              screenClass: 'NoteEditorScreen',
              parameters: {'entry_time': DateTime.now().toIso8601String()},
            );
            return PageTransitions.slideFromBottomTransition(
              const NoteEditorScreen(),
              name: Routing.planAddNote.routeName,
            );
          },
        ),
      ],
    );
  }
}
