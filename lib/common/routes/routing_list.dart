enum Routing {
  splash(path: '/', routeName: 'splash'),
  auth(path: '/auth', routeName: 'auth'),
  home(path: '/home', routeName: 'home'),
  tourismSpot(path: '/tourism_spot', routeName: 'tourism_spot'),
  tourismSpotPreview(
    path: 'preview/:id', // inside tourism_spot
    routeName: 'tourism_spot.preview',
  ),
  tourismSpotDetail(
    path: 'detail', // inside tourism_spot
    routeName: 'tourism_spot.detail',
  ),
  settings(path: '/settings', routeName: 'settings'),
  about(path: '/settings/about', routeName: 'about'),
  aiChat(path: '/ai_chat', routeName: 'ai_chat'),
  bookmarks(path: '/bookmarks', routeName: 'bookmarks'),
  plan(path: '/plan', routeName: 'plan'),
  planSearch(path: '/plan/search-tour', routeName: 'plan.search_tour'),
  planAdd(path: '/plan/add-tour', routeName: 'plan.add_tour'),
  planAddNote(path: '/plan/add-note', routeName: 'plan.add_note');

  final String path;
  final String routeName;

  const Routing({required this.path, required this.routeName});
}
