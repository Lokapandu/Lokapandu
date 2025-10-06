import 'package:flutter/widgets.dart';
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
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_detail_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_page.dart';
import 'package:lokapandu/presentation/tourism_spot/pages/tourism_spot_preview_page.dart';

sealed class Routing {
  final String path;
  final String routeName;
  final Widget Function({dynamic arguments}) pageComponent;

  const Routing(this.path, this.routeName, this.pageComponent);
}

class SplashRoute extends Routing {
  SplashRoute() : super('/', 'splash', ({dynamic arguments}) => SplashScreen());
}

class AuthRoute extends Routing {
  AuthRoute() : super('/auth', 'auth', ({dynamic arguments}) => AuthScreen());
}

class HomeRoute extends Routing {
  HomeRoute() : super('/home', 'home', ({dynamic arguments}) => HomeContent());
}

class TourismSpotRoute extends Routing {
  TourismSpotRoute()
    : super(
        '/tourism_spot',
        'tourism_spot',
        ({dynamic arguments}) => TourismSpotPage(),
      );
}

class TourismSpotPreviewRoute extends Routing {
  TourismSpotPreviewRoute()
    : super(
        '/tourism_spot/preview/:id',
        'tourism_spot.preview',
        ({dynamic arguments}) => TourismSpotPreviewPage(id: arguments as int),
      );
}

class TourismSpotDetailRoute extends Routing {
  TourismSpotDetailRoute()
    : super(
        '/tourism_spot/detail',
        'tourism_spot.detail',
        ({dynamic arguments}) =>
            TourismSpotDetailPage(tour: arguments as TourismSpot),
      );
}

class SettingsRoute extends Routing {
  SettingsRoute()
    : super('/settings', 'settings', ({dynamic arguments}) => SettingsScreen());
}

class AiChatRoute extends Routing {
  AiChatRoute()
    : super('/ai_chat', 'ai_chat', ({dynamic arguments}) => AiChatScreen());
}

class BookmarksRoute extends Routing {
  BookmarksRoute()
    : super(
        '/bookmarks',
        'bookmarks',
        ({dynamic arguments}) => BookmarkScreen(),
      );
}

class PlanRoute extends Routing {
  PlanRoute() : super('/plan', 'plan', ({dynamic arguments}) => PlanScreen());
}

class PlanSearchRoute extends Routing {
  PlanSearchRoute()
    : super(
        '/plan/search-tour',
        'plan.search_tour',
        ({dynamic arguments}) => TourSearchScreen(),
      );
}

class PlanAddRoute extends Routing {
  PlanAddRoute()
    : super(
        '/plan/add-tour',
        'plan.add_tour',
        ({dynamic arguments}) => TourPlanEditorScreen(),
      );
}

class PlanAddNoteRoute extends Routing {
  PlanAddNoteRoute()
    : super(
        '/plan/add-note',
        'plan.add_note',
        ({dynamic arguments}) => NoteEditorScreen(),
      );
}
