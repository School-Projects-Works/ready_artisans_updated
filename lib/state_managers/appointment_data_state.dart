import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/models/appointment_model.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';

import '../components/smart_dialog.dart';
import 'user_data_state.dart';

final newAppointmentProvider =
    StateNotifierProvider.autoDispose<AppointmentDataState, AppointmentModel>(
        (ref) => AppointmentDataState());

class AppointmentDataState extends StateNotifier<AppointmentModel> {
  AppointmentDataState() : super(AppointmentModel());
  void addAppointment(AppointmentModel appointment) {
    state = appointment;
  }

  void bookAppointment(
      {required UserModel artisan,
      required BuildContext context,
      required WidgetRef ref,
      double? perHourRate,
      String? note}) async {
    if (artisan.available ?? true) {
      CustomDialog.showLoading(message: 'Sending request...');
      var client = ref.read(userProvider);
      state = state.copyWith(
          id: FireStoreServices.getDocumentId('requests'),
          artisanId: artisan.id,
          artisanName: artisan.name,
          artisanImage: artisan.image,
          artisanCategory: artisan.artisanCategory,
          clientId: client.id,
          clientName: client.name,
          clientImage: client.image,
          clientPhone: client.phone,
          clientAddress: client.address,
          clientEmail: client.email,
          artisanPhone: artisan.phone,
          artisanAddress: artisan.address,
          artisanEmail: artisan.email,
          artisanLatitude: artisan.latitude,
          artisanLongitude: artisan.longitude,
          clientLatitude: client.latitude,
          clientLongitude: client.longitude,
          clientLocation: client.location,
          artisanLocation: artisan.location,
          ids: [client.id, artisan.id],
          status: 'Pending',
          paid: false,
          note: note,
          perHourRate: perHourRate,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      await FireStoreServices.addAppointment(state).then((value) {
        CustomDialog.dismiss();
        CustomDialog.showSuccess(
            title: 'Success',
            onOkayPressed: () {
              ref.read(homePageIndexProvider.notifier).state = 1;
              //Navigator.of(context).pop();
            },
            message: 'Your request has been sent to ${artisan.name}');
        ref.read(homePageIndexProvider.notifier).state = 1;
        // Navigator.pop(context);
      }).catchError((e) {
        CustomDialog.dismiss();
        CustomDialog.showError(
            title: 'Error', message: 'An error occurred, please try again');
      });
    } else {
      CustomDialog.showError(
          title: 'Unavailable',
          message: 'This artisan is currently unavailable');
    }
  }
}

final appointmentStreamProvider =
    StreamProvider<List<AppointmentModel>>((ref) async* {
  var uid = ref.read(userProvider).id;
  var data = FireStoreServices.getResquests(uid);
  ref.onDispose(() {
    data.drain();
  });
  List<AppointmentModel> appointments = [];
  await for (var item in data) {
    appointments =
        item.docs.map((e) => AppointmentModel.fromMap(e.data())).toList();
    yield appointments;
  }
});

final appointmentWithArtisanListProvider =
    StateProvider.family<List<AppointmentModel>, String>((ref, id) {
  var appointments = ref.watch(appointmentStreamProvider);
  List<AppointmentModel> data = [];

  appointments.whenData((value) {
    data = value
        .where((element) =>
            element.artisanId == id &&
            (element.status == 'Pending' || element.status == 'Started'))
        .toList();
  });
  return data;
});
