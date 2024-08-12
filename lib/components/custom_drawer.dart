import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/state_managers/user_data_state.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import '../generated/assets.dart';
import '../pages/new_artisan/new_artisan_page.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var _user = ref.read(userProvider);
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 110,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _user.image == null || _user.image!.isEmpty
                          ? const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(_user.image!),
                                    fit: BoxFit.fill),
                              ),
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              _user.name!,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {},
                                child: Text(
                                  'Profile',
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 3,
                  color: Colors.grey,
                ),
                ListTile(
                  leading:
                      const Icon(Icons.home, size: 30, color: Colors.black54),
                  title: Text(
                    'Home',
                    style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: switchPage(context, 0),
                ),
                ListTile(
                  leading: const Icon(Icons.history,
                      size: 30, color: Colors.black54),
                  title: Text(
                    'My Orders',
                    style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: switchPage(context, 1),
                ),
                if (_user.userType!.toLowerCase() == 'artisan')
                  ListTile(
                    leading: const Icon(Icons.monetization_on,
                        size: 30, color: Colors.black54),
                    title: Text(
                      'My Jobs',
                      style: GoogleFonts.nunito(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onTap: switchPage(context, 2),
                  ),
                ListTile(
                  leading: const Icon(Icons.support_agent_rounded,
                      size: 30, color: Colors.black54),
                  title: Text(
                    'Support',
                    style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: switchPage(context, 3),
                ),
                ListTile(
                    leading:
                        const Icon(Icons.info, size: 30, color: Colors.black54),
                    title: Text(
                      'About',
                      style: GoogleFonts.nunito(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onTap: () {}),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                ListTile(
                    leading: const Icon(Icons.logout,
                        size: 30, color: Colors.black54),
                    title: Text(
                      'Sign Out',
                      style: GoogleFonts.nunito(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onTap: () {}),
                const Spacer(),
                if (_user.userType!.toLowerCase() != 'artisan')
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewArtisanPage()));
                    },
                    child: Container(
                      width: size.width,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Become an Artisan',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Provide service and earn money',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_user.userType!.toLowerCase() == 'artisan')
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.imagesLogoHT,
                          height: 90,
                        ),
                        Text(
                          'Powered by Fihankra',
                          style: GoogleFonts.nunito(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          'Version 1.0.0',
                          style: GoogleFonts.nunito(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  switchPage(BuildContext context, int i) {}
}
