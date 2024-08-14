import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/components/smart_dialog.dart';
import 'package:ready_artisans/constant/functions.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';

import '../../../services/firestore_services.dart';
import '../../../state_managers/appointment_data_state.dart';
import '../../../state_managers/user_data_state.dart';
import '../../new_artisan/new_artisan_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = ref.watch(userProvider);
    var request = ref.watch(appointmentStreamProvider);
    return Column(
      children: [
        Container(
          height: size.height * .3,
          color: secondaryColor,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // circular avatar with bother and edit button
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                      image: NetworkImage(user.image.isNotEmpty
                          ? user.image
                          : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(height: 10),
            Text(
              user.name,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              user.email,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 5),
            Text(
              user.phone,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(children: [
                Chip(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: request.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Text(
                                      '${data.length}',
                                      style: GoogleFonts.podkova(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: secondaryColor),
                                    ),
                                    Text(
                                      user.userType.toLowerCase() == 'client'
                                          ? 'Total Requests'
                                          : 'Services provided',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                  ],
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (error, stack) {
                                return Center(child: Text(error.toString()));
                              }),
                        )),
                        const SizedBox(width: 10),
                        const VerticalDivider(
                          indent: 40,
                          endIndent: 10,
                          width: 50,
                          color: Colors.black45,
                          thickness: 2,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Text(
                                user.userType.toLowerCase() == 'client'
                                    ? '10%'
                                    : '4',
                                style: GoogleFonts.podkova(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor),
                              ),
                              Text(
                                user.userType.toLowerCase() == 'client'
                                    ? 'Discount & coupons'
                                    : 'Years of experience',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (user.userType.toLowerCase() == 'artisan')
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () {
                        sendToPage(context, const NewArtisanPage());
                      },
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            sendToPage(context, const NewArtisanPage());
                          },
                          child: Text(
                            'Start',
                            style: normalText(color: Colors.white),
                          )),
                      title: Text(
                        'Make me a Customer',
                        style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        'Become a customer and start requesting for services',
                        style: GoogleFonts.nunito(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                if (user.userType.toLowerCase() != 'artisan')
                  //become artisan card
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () {
                        sendToPage(context, const NewArtisanPage());
                      },
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            sendToPage(context, const NewArtisanPage());
                          },
                          child: Text(
                            'Start',
                            style: normalText(color: Colors.white),
                          )),
                      title: Text(
                        'Become an Artisan',
                        style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        'Become an artisan and start earning',
                        style: GoogleFonts.nunito(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                if (user.userType.toLowerCase() == 'artisan' &&
                    user.status != 'pending')
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: user.available
                          ? Colors.green.withOpacity(.2)
                          : Colors.red.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      trailing: Switch(
                        value: user.available,
                        onChanged: (value) {
                          ref
                              .read(userProvider.notifier)
                              .updateUserAvailable(value);
                        },
                        activeColor: secondaryColor,
                      ),
                      title: Text(
                        'Available Status',
                        style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        user.available
                            ? 'You are avtive on the market'
                            : 'You are not avtive on the market',
                        style: GoogleFonts.nunito(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    CustomDialog.showInfo(
                        title: 'Logout',
                        message: 'Are you sure you want to logout?',
                        onConfirmText: 'Logout',
                        onConfirm: () {
                          ref.read(userProvider.notifier).logout(context);
                        });
                  },
                  leading: const Icon(Icons.logout, color: Colors.black),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  endIndent: 15,
                  indent: 15,
                  color: Colors.grey,
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }

  void checkAndContinue() async {
    CustomDialog.showLoading(message: 'Updating...');

    //change userType to artisan
    var user = ref.read(userProvider);
    user = user.copyWith(
      userType: 'client',
    );
    bool results = await FireStoreServices.updateUserToArtisan(user);
    //save service details
    //daley for 3 seconds
    if (results) {
      ref.read(userProvider.notifier).logout(context);
      await Future.delayed(const Duration(seconds: 3));
      CustomDialog.dismiss();
    } else {
      CustomDialog.showError(title: 'Error', message: 'An error occurred');
    }
  }
}
