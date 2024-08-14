import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ready_artisans/admin/dashboard/main_page.dart';
import '../admin/artisans/artisans_page.dart';
import '../admin/auth/views/login_page.dart';
import '../admin/categories/views/categories_page.dart';
import '../admin/clients/client_page.dart';
import '../admin/dashboard/home_page.dart';
import 'router_items.dart';

class MyRouter {
  final WidgetRef ref;
  final BuildContext context;
  MyRouter({
    required this.ref,
    required this.context,
  });
  router() => GoRouter(
          initialLocation: RouterItem.loginRoute.path,
          redirect: (context, state) {
            var route = state.fullPath;
            //check if widget is done building
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (route != null && route.isNotEmpty) {
                var item = RouterItem.getRouteByPath(route);
                ref.read(routerProvider.notifier).state = item.name;
              }
            });
            return null;
          },
          routes: [
            GoRoute(
                path: RouterItem.loginRoute.path,
                builder: (context, state) {
                  return const LoginPage();
                }),
            ShellRoute(
                builder: (context, state, child) {
                  return DashboardMain(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                      path: RouterItem.dashboardRoute.path,
                      builder: (context, state) {
                        return const DashboardHome();
                      }),
                  GoRoute(
                      path: RouterItem.artisansRoute.path,
                      builder: (context, state) {
                        return  const ArtisansPage();
                      }),
                  GoRoute(
                      path: RouterItem.categoriesRoute.path,
                      builder: (context, state) {
                        return const CategoriesPage();
                      }),
                  GoRoute(
                      path: RouterItem.usersRoute.path,
                      builder: (context, state) {
                        return const ClientPage();
                      }),
                  GoRoute(
                      path: RouterItem.bookingRoute.path,
                      builder: (context, state) {
                        return const Center(
                            child: Text(
                                'Booking Page not showing due to version difference'));
                      })
                ])
          ]);

  void navigateToRoute(RouterItem item) {
    ref.read(routerProvider.notifier).state = item.name;
    context.go(item.path);
  }

  void navigateToNamed(
      {required Map<String, String> pathPrams,
      required RouterItem item,
      Map<String, dynamic>? extra}) {
    ref.read(routerProvider.notifier).state = item.name;
    context.goNamed(item.name, pathParameters: pathPrams, extra: extra);
  }
}

final routerProvider = StateProvider<String>((ref) {
  return RouterItem.loginRoute.name;
});
