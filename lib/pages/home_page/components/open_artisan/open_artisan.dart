import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/components/text_inputs.dart';
import 'package:ready_artisans/constant/functions.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';

import '../../../../components/custom_button.dart';
import '../../../../generated/assets.dart';
import '../../../../state_managers/appointment_data_state.dart';
import '../../../../state_managers/review_data_state.dart';
import 'top_view.dart';

class ArtisanDetailPage extends ConsumerStatefulWidget {
  const ArtisanDetailPage(this.artisan, {super.key});
  final UserModel artisan;

  @override
  ConsumerState<ArtisanDetailPage> createState() => _ArtisanDetailPageState();
}

class _ArtisanDetailPageState extends ConsumerState<ArtisanDetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var artisan = widget.artisan;
    var reviews = ref.watch(reviewStreamProvider(artisan.id));
    var appointments = ref.watch(appointmentStreamProvider);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: secondaryColor,
        elevation: 0,
        title: Image.asset(
          Assets.imagesLogoHT,
          height: 70,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              OpenArtisanTop(artisan: artisan),
              const SizedBox(height: 20),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Price Details',
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  subtitle: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Per Hour',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54)),
                                      Text('GHC ${artisan.perHourRate}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black54,
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Transport',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54)),
                                      Text('GHC 50',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black54,
                                    height: 25,
                                  ),
                                  //discount
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: 'Discount',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54),
                                              children: [
                                            TextSpan(
                                              text: ' (5% off)',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: secondaryColor),
                                            )
                                          ])),
                                      Text('GHC 0',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black54,
                                    height: 25,
                                  ),
                                  //total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54)),
                                      Text('GHC ${artisan.perHourRate + 50}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              )))
                      ),
              const SizedBox(height: 10),
              appointments.when(data: (data) {
                var appointment = data
                    .where((element) =>
                        element.artisanId == artisan.id &&
                        (element.status == 'Pending' ||
                            element.status == 'Started'))
                    .toList();
                return Column(
                  children: [
                    //book button
                    if (appointment.isNotEmpty)
                      Text(
                        'You have a pending or Started request with this Artisan',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w800),
                      ),
                    if (appointment.isNotEmpty)
                      ElevatedButton(
                          onPressed: () {
                            ref.read(homePageIndexProvider.notifier).state = 1;
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'View Request Page',
                            style: normalText(color: Colors.white),
                          )),

                    if (appointment.isEmpty)
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: CustomButton(
                              text: 'Book Artisan',
                              onPressed: () {
                                //open bottom sheet to enter additional note and book
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Additional Note',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              const SizedBox(height: 10),
                                              CustomTextFields(
                                                controller: _controller,
                                                maxLines: 5,
                                                hintText:
                                                    'Enter additional note',
                                              ),
                                              const SizedBox(height: 10),
                                              CustomButton(
                                                  text: 'Book',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    ref
                                                        .read(
                                                            newAppointmentProvider
                                                                .notifier)
                                                        .bookAppointment(
                                                          artisan: artisan,
                                                          context: context,
                                                          ref: ref,
                                                          perHourRate: artisan
                                                              .perHourRate,
                                                          note:
                                                              _controller.text,
                                                        );
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              })),
                  ],
                );
              }, error: (e, s) {
                return const Center(child: Text('Something went wrong'));
              }, loading: () {
                return const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()));
              }),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    Text('Reviews',
                        style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          //TODO: view all reviews
                        },
                        child: Text('View All', style: GoogleFonts.roboto()))
                  ],
                ),
                subtitle: reviews.when(data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text('No reviews yet'));
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var review = data[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: review.senderImage != null
                                    ? NetworkImage(review.senderImage!)
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(review.senderName!,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const Spacer(),
                                      const Icon(Icons.star,
                                          color: secondaryColor),
                                      Text(review.rating!.toStringAsFixed(1),
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(review.message!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54)),
                                  const SizedBox(height: 5),
                                  Text(
                                    getDateFromDate(review.createdAt!),
                                    style: normalText(
                                        fontSize: 13, color: Colors.black54),
                                  )
                                ],
                              ))
                            ]),
                          );
                        });
                  }
                }, error: (e, s) {
                  return const Center(child: Text('Something went wrong'));
                }, loading: () {
                  return const Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator()));
                }),
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
