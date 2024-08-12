import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_artisans/components/smart_dialog.dart';
import '../../state_managers/navigation_state.dart';
import '../../styles/app_colors.dart';
import '../../generated/assets.dart';

class ImagesSection extends ConsumerStatefulWidget {
  const ImagesSection({super.key});

  @override
  ConsumerState<ImagesSection> createState() => _ImagesSectionState();
}

class _ImagesSectionState extends ConsumerState<ImagesSection> {
  File? idBack, idFront, profileImage;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            height: size.height - 152,
            child: SingleChildScrollView(
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
                        Text('ID & Image',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Text(
                            'Upload a clear front and back image of your Ghana Card as well as a clear image of yourself for verification.Please Note that your Ghana Card Number should match the Card Number used during account creation.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        image: idFront != null
                            ? DecorationImage(
                                image: FileImage(idFront!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage(Assets.imagesPlaceholder),
                                fit: BoxFit.cover)),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        _pickImage();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload ID Front',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        image: idBack != null
                            ? DecorationImage(
                                image: FileImage(idBack!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage(Assets.imagesPlaceholder),
                                fit: BoxFit.cover)),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        _pickIdBack();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload ID Back',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * .7,
                    height: size.width * .7,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        image: profileImage != null
                            ? DecorationImage(
                                image: FileImage(profileImage!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage(Assets.imagesPlaceholder),
                                fit: BoxFit.cover)),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        _pickProfileImage();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload Your Image',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            height: 40,
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
                onPressed: () => checkAndContinue(),
                icon: const Icon(FontAwesomeIcons.arrowRight,
                    color: secondaryColor),
                label: Text(
                  'Continue',
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }

  void _pickImage() {
    var picker = ImagePicker();
    CustomDialog.showCustom(
        ui: Container(
      color: Colors.white,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select source of image',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              setState(() {
                idFront = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                idFront = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              CustomDialog.dismiss();
            },
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
          ),
        ],
      ),
    ));
  }

  void _pickIdBack() {
    var picker = ImagePicker();
    CustomDialog.showCustom(
        ui: Container(
      color: Colors.white,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select source of image',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              setState(() {
                idBack = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                idBack = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              CustomDialog.dismiss();
            },
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
          ),
        ],
      ),
    ));
  }

  void _pickProfileImage() {
    var picker = ImagePicker();
    CustomDialog.showCustom(
        ui: Container(
      color: Colors.white,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select source of image',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              setState(() {
                profileImage = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
          ),
          ListTile(
            onTap: () async {
              var pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                profileImage = File(pickedFile!.path);
                CustomDialog.dismiss();
              });
            },
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              CustomDialog.dismiss();
            },
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
          ),
        ],
      ),
    ));
  }

  void checkAndContinue() async {
    if (idFront == null || idBack == null || profileImage == null) {
      CustomDialog.showError(
          title: 'Error', message: 'Please upload all images');
    } else {
      ref.read(newArtisanIndexProvider.notifier).state = 1;
    }
  }
}
