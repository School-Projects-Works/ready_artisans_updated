// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/components/smart_dialog.dart';
import 'package:ready_artisans/constant/functions.dart';
import 'package:ready_artisans/models/user_location_model.dart';
import 'package:ready_artisans/services/firebase_auth_services.dart';
import 'package:ready_artisans/services/firebase_storage.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';
import '../models/user_model.dart';
import '../pages/welcome_page/welcome_page.dart';
import 'location_data_state.dart';

final userProvider = StateNotifierProvider<UserDataState, UserModel>((ref) {
  return UserDataState();
});

class UserDataState extends StateNotifier<UserModel> {
  UserDataState() : super(UserModel.empty());
  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = UserModel.empty();
  }

  void setEmail(String s) {
    state = state.copyWith(email: s);
  }

  void setIdCard(String s) {
    state = state.copyWith(idNumber: s);
  }

  void setName(String s) {
    state = state.copyWith(name: s);
  }

  void setgender(param0) {
    state = state.copyWith(gender: param0.toString());
  }

  void setPhone(String s) {
    state = state.copyWith(phone: s);
  }

  void setAddress(String s) {
    state = state.copyWith(address: s);
  }

  void createUser(BuildContext context, WidgetRef ref,
      {required File image, String? password}) async {
    CustomDialog.showLoading(
      message: 'Creating Account...',
    );
    state = state.copyWith(
        createdAt: DateTime.now().millisecondsSinceEpoch, userType: 'client');
    var user = await FirebaseAuthService.createUserWithEmailAndPassword(
        state.email, password!);
    if (user != null) {
      await FirebaseAuthService.sendEmailVerification();
      var location = ref.read(locationStreamProvider);
      location.whenData((value) {
        state.copyWith(
          location: value.toMap(),
          latitude: value.latitude,
          longitude: value.longitude,
          city: value.city,
          region: value.region,
        );
      });
      state = state.copyWith(
          id: user.uid,
          userType: 'client',
          rating: 2.0,
          available: true,
          createdAt: DateTime.now().toUtc().millisecondsSinceEpoch);
      //save user image to cloud storage
      final userImageUrl =
          await CloudStorageServices.saveUserImage(image, state.id.toString());
      state = state.copyWith(image: userImageUrl);
      //save user to firestore
      final String response = await FireStoreServices.saveUser(state);
      if (response == 'success') {
        // clear all states
        ref.read(userProvider.notifier).state = UserModel.empty();
        await FirebaseAuthService.signOut();
        CustomDialog.dismiss();
        CustomDialog.showSuccess(
          title: 'Success',
          message:
              'User created successfully\n A verification email has been sent to your email address\n Please verify your email address to login',
        );
        ref.read(authNavProvider.notifier).state = 0;
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(
          title: 'Error',
          message: response,
        );
      }
    }
  }

  void updateUserAvailable(bool available) async {
    state = state.copyWith(available: available);
    await FireStoreServices.updateUserAvailableStatus(state.id, available);
  }

  void logout(BuildContext context) async {
    CustomDialog.dismiss();
    await FirebaseAuthService.signOut();
    clearUser();
    if (mounted) {
      sendToPage(context, const WelcomePage());
    }
  }

  void updateUserLocation(UserLocation location) async {
    state = state.copyWith(
        location: state.toMap(),
        latitude: state.latitude,
        longitude: state.longitude,
        city: state.city,
        region: state.region);
    //await FireStoreServices.updateUserLocation(state);
  }

  void setUserType(String s, String artisanCategory) {
    state = state.copyWith(userType: s, artisanCategory: artisanCategory);
  }
}
