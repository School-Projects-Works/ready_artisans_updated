import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/components/smart_dialog.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';
import '../../components/custom_dropdown.dart';
import '../../components/custom_input.dart';
import '../../state_managers/category_data_state.dart';
import '../../state_managers/user_data_state.dart';
import '../../styles/app_colors.dart';

class ServiceDetails extends ConsumerStatefulWidget {
  const ServiceDetails({super.key});

  @override
  ConsumerState<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends ConsumerState<ServiceDetails> {
  String? selectedService;
  String? title;
  String? description;
  String? tags;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var category = ref.watch(categoryStreamProvider);
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              width: size.width,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Services Details',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text(
                      'Please provide the details of the services you offer. This will help us match you with the right customers.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
                title: Text('Which of these services do you offer?',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                subtitle: category.when(
                    error: (e, s) {
                      return Text('Error: $e');
                    },
                    loading: () => const Center(
                          child: LinearProgressIndicator(),
                        ),
                    data: (data) {
                      return CustomDropDown(
                        color: Colors.white,
                        value: selectedService,
                        onChanged: (value) {
                          setState(() {
                            selectedService = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            selectedService = value;
                          });
                        },
                        items: data
                            .map((e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name,
                                      style: GoogleFonts.poppins()),
                                ))
                            .toList(),
                      );
                    })),
            const SizedBox(height: 10),
            ListTile(
              title: Text('Provide specific title for your service',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              subtitle: CustomTextFields(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    title = value;
                  });
                },
                label: 'E.g. Plumber',
              ),
            ),
            Container(
              width: size.width,
              height: 40,
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        ref.read(authNavProvider.notifier).state = 0;
                      },
                      icon: const Icon(FontAwesomeIcons.arrowLeft,
                          color: secondaryColor),
                      label: Text(
                        'Previous',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () => checkAndContinue(),
                      icon: const Icon(FontAwesomeIcons.arrowRight,
                          color: Colors.white),
                      label: Text(
                        'Submit',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAndContinue() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      CustomDialog.showLoading(message: 'Sending data..Please wait...');
      //change userType to artisan
      var user = ref.read(userProvider);
      bool results = await FireStoreServices.updateUserToArtisan(
          user.id, selectedService!);
      //save service details
      //daley for 3 seconds
      if (results) {
        ref
            .read(userProvider.notifier)
            .setUserType('artisan', selectedService!);
        await Future.delayed(const Duration(seconds: 3));
        CustomDialog.dismiss();
        CustomDialog.showSuccess(
            title: 'Success',
            message: 'You are now an Artisan',
            onOkayPressed: () {
              Navigator.of(context).pop();
            });
      } else {
        CustomDialog.showError(title: 'Error', message: 'An error occurred');
      }
    }
  }
}
