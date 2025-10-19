enum Routing {
  splash('/', 'splash'),
  auth('/auth', 'auth'),
  home('/home', 'home'),
  tourismSpot('/tourism_spot', 'tourism_spot'),
  tourismSpotPreview(
    '/preview/:id', // inside tourism_spot
    'tourism_spot.preview',
    parent: '/tourism_spot',
  ),
  tourismSpotDetail(
    '/detail', // inside tourism_spot
    'tourism_spot.detail',
    parent: '/tourism_spot',
  ),
  settings('/settings', 'settings'),
  about('/about', 'about', parent: '/settings'),
  aiChat('/ai_chat', 'ai_chat'),
  bookmarks('/bookmarks', 'bookmarks', parent: '/settings'),
  plan('/plan', 'plan'),
  planSearch('/search-tour', 'plan.search_tour', parent: '/plan'),
  planAdd('/add-tour', 'plan.add_tour', parent: '/plan'),
  planAddNote('/add-note', 'plan.add_note', parent: '/plan');

  final String? parent;
  final String path;
  final String routeName;

  const Routing(this.path, this.routeName, {this.parent});

  String get fullPath => parent == null ? path : '$parent$path';
}
