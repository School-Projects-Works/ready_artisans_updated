import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import '../constant/functions.dart';
import '../models/user_location_model.dart';

// final locationProvider =
//     StateNotifierProvider.family<LocationDataState, UserLocation, WidgetRef>(
//         (ref, ref2) {
//   return LocationDataState(ref2);
// });

// class LocationDataState extends StateNotifier<UserLocation> {
//   LocationDataState(this.ref) : super(UserLocation()) {
//     getCurrentPosition(ref);
//   }
//   final WidgetRef ref;
// }

final locationStreamProvider = StreamProvider<UserLocation>((ref) async* {
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  if (await getLocationPermission()) {
    Stream<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings);
    await for (Position position in positionStream) {
      if (position.latitude != null) {
        UserLocation location = UserLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        await geo
            .placemarkFromCoordinates(position.latitude, position.longitude)
            .then((List<geo.Placemark> placeMarks) {
          geo.Placemark place = placeMarks[0];
          location = UserLocation(
            latitude: position.latitude,
            longitude: position.longitude,
            name: place.name,
            street: place.street,
            city: place.locality,
            region: place.administrativeArea,
            country: place.country,
            countryCode: place.isoCountryCode,
            district: place.subAdministrativeArea,
          );
        });
        yield location;
      }
    }
  }
});
