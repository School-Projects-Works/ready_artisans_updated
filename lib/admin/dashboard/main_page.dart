import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/admin/provider/admin_provider.dart';
import '../../generated/assets.dart';
import '../../router/router.dart';
import '../../router/router_items.dart';
import '../../styles/app_colors.dart';
import '../../styles/styles_admin.dart';
import 'components/app_bar_item.dart';
import 'components/side_bar.dart';

class DashboardMain extends ConsumerStatefulWidget {
  const DashboardMain({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var artisans = ref.watch(artisanStreamProvider);
    var categories = ref.watch(categoriesStream);
    
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              children: [
                Image.asset(
                  Assets.imagesIcon,
                  height: 40,
                ),
                const SizedBox(width: 10),
                if (styles.smallerThanTablet)
                  //manu button

                  buildAdminManu(ref, context)
              ],
            ),
          ),
          body: Container(
            color: Colors.white60,
            padding: const EdgeInsets.all(4),
            child: styles.smallerThanTablet
                ? widget.child
                : Row(
                    children: [
                      const SideBar(),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                              color: Colors.grey[100],
                              padding: const EdgeInsets.all(10),
                              child: categories.when(
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (error, stack) {
                                  return Center(child: Text(error.toString()));
                                },
                                data: (data) {
                                  return artisans.when(
                                      data: (user) {
                                        return widget.child;
                                      },
                                      loading: () =>
                                          const Center(child: CircularProgressIndicator()),
                                      error: (error, stack) {
                                        return Center(child: Text(error.toString()));
                                      }
                                      );
                                },
                              )))
                    ],
                  ),
          )),
    );
  }

  Widget buildAdminManu(WidgetRef ref, BuildContext context) {
    return PopupMenuButton(
      color: primaryColor,
      offset: const Offset(0, 70),
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.dashboard,
                title: 'Dashboard',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.dashboardRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.location_on,
                title: 'Artisans',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.artisansRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.warning,
                title: 'Users',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.usersRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.contact_phone,
                title: 'Categories',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.categoriesRoute);
                  Navigator.of(context).pop();
                }),
          ),
         ];
      },
    );
  }
}

