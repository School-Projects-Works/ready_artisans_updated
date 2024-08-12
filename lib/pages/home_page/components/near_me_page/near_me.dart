import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/components/custom_button.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/pages/home_page/components/artisan_card.dart';
import 'package:ready_artisans/styles/styles.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../../../constant/functions.dart';
import '../../../../generated/assets.dart';
import '../../../../models/user_location_model.dart';
import '../../../../state_managers/artisans_data_state.dart';
import '../../../../styles/app_colors.dart';

class ArtisansNearMe extends ConsumerStatefulWidget {
  const ArtisansNearMe(this.location, {super.key});
  final UserLocation location;

  @override
  ConsumerState<ArtisansNearMe> createState() => _ArtisansNearMeState();
}

class _ArtisansNearMeState extends ConsumerState<ArtisansNearMe> {
  bool _showFirstWidget = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        _showFirstWidget = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var artisans = ref.watch(artisanStreamProvider);
    return Scaffold(
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
        body: !_showFirstWidget
            ? artisans.when(data: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      'No Artisans Near You',
                      style: normalText(),
                    ),
                  );
                } else {
                  var inRegion = data
                      .where(
                          (element) => element.region == widget.location.region)
                      .toList();
                  var inCity = data
                      .where((element) => element.city == widget.location.city)
                      .toList();
                  var inCircle = getArtisansWithinCircle(data,
                      widget.location.latitude!, widget.location.longitude!);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: ListTile(
                              title: Text(
                                'Within 5km',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor),
                              ),
                              subtitle: inCircle.isEmpty
                                  ? Text(
                                      'No Artisan found with this range',
                                      style: normalText(),
                                    )
                                  : ListView.builder(
                                      itemCount: inCircle.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ArtisanCard(
                                          artisan: inCircle[index],
                                        );
                                      }),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListTile(
                              title: Text(
                                'Within My Region',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor),
                              ),
                              subtitle: inRegion.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: inRegion.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ArtisanCard(
                                          artisan: inRegion[index],
                                        );
                                      })
                                  : Text(
                                      'No Artisan found within your region',
                                      style: normalText(),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListTile(
                              title: Text(
                                'Within My City',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor),
                              ),
                              subtitle: inCity.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: inCity.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ArtisanCard(
                                          artisan: inCity[index],
                                        );
                                      })
                                  : Text(
                                      'No Artisan found within your city',
                                      style: normalText(),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                              text: 'Look Again',
                              onPressed: () {
                                setState(() {
                                  _showFirstWidget = true;
                                });
                                _startTimer();
                              })
                        ],
                      ),
                    ),
                  );
                }
              }, error: (e, s) {
                return Center(
                  child: Text(
                    'Unable to load Artisans Near You',
                    style: normalText(),
                  ),
                );
              }, loading: () {
                return const Center(
                  child: RippleAnimation(
                    color: secondaryColor,
                    delay: Duration(milliseconds: 300),
                    repeat: true,
                    minRadius: 100,
                    ripplesCount: 6,
                    duration: Duration(milliseconds: 6 * 300),
                    child: Text('Finding Artisans Near You...'),
                  ),
                );
              })
            : const Center(
                child: RippleAnimation(
                  color: secondaryColor,
                  delay: Duration(milliseconds: 300),
                  repeat: true,
                  minRadius: 100,
                  ripplesCount: 6,
                  duration: Duration(milliseconds: 6 * 300),
                  child: Text('Finding Artisans Near You...'),
                ),
              ));
  }

  List<UserModel> getArtisansWithinCircle(
      List<UserModel> data, double lat, double long) {
    var artisans = data
        .where(
            (element) => element.latitude != null && element.longitude != null)
        .toList();
    var artisansWithinCircle = <UserModel>[];
    for (var artisan in artisans) {
      var distance = calculateDistance(
          lat1: lat,
          lon1: long,
          lat2: artisan.latitude!,
          lon2: artisan.longitude!);
      if (distance <= 10) {
        artisansWithinCircle.add(artisan);
      }
    }
    return artisansWithinCircle;
  }
}
