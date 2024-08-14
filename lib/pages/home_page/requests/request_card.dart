import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ready_artisans/admin/core/funnnctions/sms_functions.dart';
import 'package:ready_artisans/constant/functions.dart';
import 'package:ready_artisans/models/appointment_model.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';

import '../../../components/smart_dialog.dart';
import '../../../state_managers/user_data_state.dart';

class RequestCard extends ConsumerWidget {
  const RequestCard({super.key, required this.data});
  final AppointmentModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(userProvider);
    return Card(
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
        iconColor: Colors.black,
        collapsedIconColor: Colors.grey,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.artisanCategory,
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  data.status,
                  style: GoogleFonts.roboto(
                      color: data.status == 'Pending'
                          ? Colors.orange
                          : data.status == 'Rejected'
                              ? Colors.red
                              : data.status == 'Complete'
                                  ? Colors.black45
                                  : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    user.id == data.artisanId
                        ? data.clientName
                        : data.artisanName,
                    style: normalText(color: Colors.black54, fontSize: 16),
                  ),
                ),
                Text(
                  getDateFromDate(data.createdAt),
                  style: normalText(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w700),
                )
              ],
            )
          ],
        ),
        children: [
          const Divider(
            color: Colors.black45,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(children: [
              const Icon(Icons.location_pin, color: secondaryColor),
              const SizedBox(width: 10),
              Text(
                'Job Location',
                style: GoogleFonts.roboto(
                    fontSize: 19, fontWeight: FontWeight.w600),
              ),
            ]),
            subtitle: Column(children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Region: ',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const Expanded(
                      child: Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black45,
                  )),
                  Text(
                      data.clientLocation['region'].toString().split(':')[0])
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('District: ',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const Expanded(
                      child: Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black45,
                  )),
                  Text(data.clientLocation['district']
                      .toString()
                      .split(':')[0])
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('City: ',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const Expanded(
                      child: Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black45,
                  )),
                  Text(data.clientLocation['city'].toString().split(':')[0])
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Address: ',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const Expanded(
                      child: Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black45,
                  )),
                  Text(data.clientAddress.toString())
                ],
              ),
              TextButton(
                  onPressed: () {
                    MapsLauncher.launchCoordinates(
                        data.clientLatitude, data.clientLongitude);
                                    },
                  child: Text(
                    'View on map',
                    style: normalText(color: secondaryColor, fontSize: 16),
                  )),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    const Icon(Icons.phone, color: secondaryColor),
                    const SizedBox(width: 10),
                    Text(
                      user.id == data.clientId
                          ? 'Artisan Contact'
                          : 'Client Contact ',
                      style: GoogleFonts.roboto(
                          fontSize: 19, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                subtitle: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          user.id == data.clientId
                              ? data.artisanPhone
                              : data.clientPhone ?? '',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )),
                        TextButton(
                            onPressed: () {
                              launchURL(
                                  'tel:${user.id == data.clientId ? data.artisanPhone ?? '' : data.clientPhone ?? ''}');
                            },
                            child: Text(
                              'Call',
                              style: normalText(
                                  color: secondaryColor, fontSize: 16),
                            ))
                      ],
                    ),

                    //email
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.id == data.clientId
                                ? data.artisanEmail ?? ''
                                : data.clientEmail ?? '',
                            style: normalText(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )),
                        TextButton(
                            onPressed: () {
                              launchURL(
                                  'mailto:${user.id == data.clientId ? data.artisanEmail ?? '' : data.clientEmail ?? ''}');
                            },
                            child: Text(
                              'Email',
                              style: normalText(
                                  color: secondaryColor, fontSize: 16),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              //price title
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    const Icon(Icons.money, color: secondaryColor),
                    const SizedBox(width: 10),
                    Text(
                      'Price',
                      style: GoogleFonts.roboto(
                          fontSize: 19, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                subtitle: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Per Hour Rate: ',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )),
                        Text(
                          'GHC ${data.perHourRate}',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Transport: ',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )),
                        Text(
                          'GHC 50',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total: ',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black45,
                        )),
                        Text(
                          'GHC ${data.perHourRate + 50}',
                          style: normalText(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const Divider(
            color: Colors.black45,
          ),
          if (user.id == data.artisanId &&
              data.note.isNotEmpty)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Row(
                children: [
                  const Icon(Icons.note, color: secondaryColor),
                  const SizedBox(width: 10),
                  Text(
                    'Note',
                    style: GoogleFonts.roboto(
                        color: Colors.black54,
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              subtitle: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    data.note ?? '',
                    style: normalText(fontSize: 16),
                  ),
                ],
              ),
            ),
          if (user.id == data.artisanId && data.status == 'Pending')
            //how accept and reject buton
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Accepted'));
                      },
                      child: Text(
                        'Accept',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Rejected'));
                      },
                      child: Text(
                        'Reject',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            ),
          if (user.id == data.artisanId && data.status == 'Accepted')
            //how accept and reject buton
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Started'));
                      },
                      child: Text(
                        'Start Job',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Canclled'));
                      },
                      child: Text(
                        'Cancel Job',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            ),
          if (user.id == data.artisanId && data.status == 'Started')
            //how accept and reject buton
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Completed'));
                      },
                      child: Text(
                        'Complete Job',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Canclled'));
                      },
                      child: Text(
                        'Cancel Job',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            ),
          if (user.id == data.clientId &&
              (data.status != 'Started' ||
                  data.status != 'Completed' ||
                  data.status != 'Cacclled'))
            Row(
              children: [
                Chip(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: data.status == 'Accepted'
                        ? Colors.green
                        : data.status == 'Rejected'
                            ? Colors.red
                            : Colors.orange,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        data.status,
                        style: normalText(color: Colors.white),
                      ),
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        updateRequest(data: data.copyWith(status: 'Cacclled'));
                      },
                      child: Text(
                        'Cancel Request',
                        style: normalText(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            )
        ],
      ),
    );
  }

  void updateRequest({required AppointmentModel data}) async {
    String question = data.status == 'Accepted'
        ? 'Are you sure you want to accept this request?'
        : data.status == 'Cancelled'
            ? 'Are you sure you want to cancel this request?'
            : data.status == 'Started'
                ? 'Are you sure you want to start this request?'
                : data.status == 'Completed'
                    ? 'Are you sure you want to complete this request?'
                    : 'Are you sure you want to reject this request?';
    CustomDialog.showInfo(
        title: 'Update Request',
        message: question,
        onConfirm: () {
          update(data);
        },
        onConfirmText: 'Yes');
  }

  void update(AppointmentModel data) async {
    String message = data.status == 'Accepted'
        ? 'Accepting request...'
        : data.status == 'Cancelled'
            ? 'Cancelling request...'
            : data.status == 'Started'
                ? 'Starting request...'
                : data.status == 'Completed'
                    ? 'Completing request...'
                    : 'Rejecting request...';
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: message);
    await FireStoreServices.updateRequestStatus(data).then((value)async {
      await sendMessage(data.clientPhone, 'Request status updated to ${data.status}');
      CustomDialog.dismiss();
      CustomDialog.showSuccess(
        title: 'Success',
        message: 'Request updated successfully',
      );
    });
  }
}
