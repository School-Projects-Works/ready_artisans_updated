import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/admin/provider/admin_provider.dart';
import 'components/dasboard_item.dart';

class DashboardHome extends ConsumerStatefulWidget {
  const DashboardHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    var artisans = ref.watch(artisansFilterProvider).items;
    var categories = ref.watch(categoriesFilterProvider).items;

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runAlignment: WrapAlignment.center,
            runSpacing: 12,
            children: [
              DashBoardItem(
                  icon: Icons.location_city,
                  title: 'Artisans',
                  itemCount: artisans.length,
                  color: Colors.blue,
                  onTap: () {}),
              DashBoardItem(
                  icon: Icons.warning,
                  title: 'Users',
                  itemCount: 0,
                  color: Colors.orange,
                  onTap: () {}),
              DashBoardItem(
                  icon: Icons.contact_emergency,
                  title: 'Categories',
                  itemCount: categories.length,
                  color: Colors.green,
                  onTap: () {}),
              DashBoardItem(
                  icon: Icons.warning,
                  title: 'Bookings',
                  itemCount: 0,
                  color: Colors.purple,
                  onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
