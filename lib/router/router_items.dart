class RouterItem {
  final String path;
  final String name;
  RouterItem({
    required this.path,
    required this.name,
  });

  static final RouterItem loginRoute =
      RouterItem(path: '/login', name: 'login');
     
  static final RouterItem dashboardRoute =
      RouterItem(path: '/dashboard', name: 'dashboard');
  static final RouterItem artisansRoute =
      RouterItem(path: '/artisans', name: 'artisans');
  static final RouterItem usersRoute =
      RouterItem(path: '/users', name: 'users');
      static final RouterItem bookingRoute =
      RouterItem(path: '/booking', name: 'booking');
      static RouterItem categoriesRoute =
      RouterItem(path: '/categories', name: 'categories');
static List<RouterItem> allRoutes = [
    loginRoute,
    dashboardRoute,
    artisansRoute,
    usersRoute,
    bookingRoute,
    categoriesRoute,
  ];

  static RouterItem getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
