sealed class Routing {
  final String path;
  final String routeName;

  const Routing(this.path, this.routeName);
}

class SplashRoute extends Routing {
  const SplashRoute() : super('/', 'splash');
}

class AuthRoute extends Routing {
  const AuthRoute() : super('/auth', 'auth');
}

class HomeRoute extends Routing {
  const HomeRoute() : super('/home', 'home');
}

class TourismSpotRoute extends Routing {
  const TourismSpotRoute() : super('/tourism_spot', 'tourism_spot');
}

class TourismSpotPreviewRoute extends Routing {
  const TourismSpotPreviewRoute()
    : super('/tourism_spot/preview/:id', 'tourism_spot.preview');
}

class TourismSpotDetailRoute extends Routing {
  const TourismSpotDetailRoute()
    : super('/tourism_spot/detail', 'tourism_spot.detail');
}

class SettingsRoute extends Routing {
  const SettingsRoute() : super('/settings', 'settings');
}

class AiChatRoute extends Routing {
  const AiChatRoute() : super('/ai_chat', 'ai_chat');
}

class BookmarksRoute extends Routing {
  const BookmarksRoute() : super('/bookmarks', 'bookmarks');
}

class PlanRoute extends Routing {
  const PlanRoute() : super('/plan', 'plan');
}

class PlanSearchRoute extends Routing {
  const PlanSearchRoute() : super('/plan/search-tour', 'plan.search_tour');
}

class PlanAddRoute extends Routing {
  const PlanAddRoute() : super('/plan/add-tour', 'plan.add_tour');
}

class PlanAddNoteRoute extends Routing {
  const PlanAddNoteRoute() : super('/plan/add-note', 'plan.add_note');
}
