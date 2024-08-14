import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ready_artisans/generated/assets.dart';
import 'package:ready_artisans/pages/home_page/profile/profile_page.dart';
import 'package:ready_artisans/state_managers/user_data_state.dart';
import '../../state_managers/navigation_state.dart';
import '../../styles/app_colors.dart';
import 'artisan_home/artisan_home.dart';
import 'components/Home.dart';
import 'requests/my_orders.dart';

enum FilterValue { all, online, city, region, district, distance }

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  var breath = 0.0;

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animationController!.addListener(() {
      setState(() {
        breath = _animationController!.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
     var user = ref.watch(userProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Image.asset(
                  Assets.imagesLogoHT,
                  height: 100 - (15 * breath),
                  fit: BoxFit.fitHeight,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        body: Scaffold(
            bottomNavigationBar: Container(
              color: secondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GNav(
                  iconSize: 30,
                  tabMargin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  onTabChange: (index) {
                    ref.read(homePageIndexProvider.notifier).state = index;
                  },
                  tabActiveBorder: Border.all(
                      color: Colors.white, width: 1), // tab button border
                  padding: const EdgeInsets.all(8),
                  gap: 8,
                  activeColor: Colors.white,
                  tabs:  [
                    const GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    if (user.userType.toLowerCase() == 'artisan' &&
                        user.status.toLowerCase() == 'active')
                         const GButton(
                        icon: Icons.apps,
                        text: 'Dashboard',
                      ),
                    const GButton(
                      icon: Icons.request_page,
                      text: 'Request',
                    ),
                    const GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ]),
            ),
            body:
                getWidgets(_buildScreens(), ref.watch(homePageIndexProvider))));
  }

  List<Widget> _buildScreens() {
    var user = ref.watch(userProvider);
    return [
        const Home(),
      if (user.userType.toLowerCase() == 'artisan'&&user.status.toLowerCase() == 'active')
        const ArtisanHome(),
      const MyOrders(),
      const ProfilePage(),
    ];
  }

  Widget getWidgets(List<Widget> buildScreens, int watch) {
    switch (watch) {
      case 0:
        return buildScreens[0];
      case 1:
        return buildScreens[1];
      case 2:
        return buildScreens[2];
      case 3:
        return buildScreens[3];
      case 4:
        return buildScreens[4];
      default:
        return buildScreens[0];
    }
  }
}
