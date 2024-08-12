import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/smart_dialog.dart';
import '../models/user_model.dart';

void noReturnSendToPage(BuildContext context, Widget newPage) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => newPage),
      (route) => false);
}

void sendToPage(BuildContext context, Widget newPage) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => newPage));
}

//send to transparent page
void sendToTransparentPage(BuildContext context, Widget newPage) {
  Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return newPage;
          }));
}

List<UserModel> sortUsersByRating(List<UserModel> users) {
  users.sort((a, b) => b.rating!.compareTo(a.rating!));
  // return in descending order
  return users;
}

String getNumberOfTime(int dateTime) {
  final now = DateTime.now();
  final difference =
      now.difference(DateTime.fromMillisecondsSinceEpoch(dateTime));
  //get yesterday

  if (difference.inDays > 0 && difference.inDays < 2) {
    return "${difference.inDays} days ago";
  } else if (difference.inHours > 0 && difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else if (difference.inMinutes > 0 && difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inSeconds > 0 && difference.inSeconds < 60) {
    return "${difference.inSeconds} seconds ago";
  } else if (difference.inSeconds == 0) {
    return "Just now";
  } else {
    //return date with format EEE, MMM d, yyyy
    return DateFormat('EEE, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
  }
}

extension TOD on TimeOfDay {
  DateTime toDateTime() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, 1, hour, minute);
  }
}

String getDateFromDate(int? dateTime) {
  if (dateTime != null) {
    return DateFormat('EEE, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
  } else {
    return '';
  }
}

String getTimeFromDate(int? dateTime) {
  if (dateTime != null) {
    return DateFormat('hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
  } else {
    return '';
  }
}

List<int> getRandomList(List<Map<String, dynamic>> data, int length) {
  final random = Random();
  List<int> list = [];
  for (int i = 0; i < length; i++) {
    list.add(data[random.nextInt(data.length)]['ID']);
  }
  return list;
}

// url launcher

void launchURL(String url) async {
  try {
    if (url.isNotEmpty) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        CustomDialog.showError(
            title: 'Error', message: 'Could not launch $url');
      }
    }
  } catch (error) {
    print('Error=================================$error');
    CustomDialog.showError(title: 'Error', message: 'Could not launch $url');
  }
}

String? dueIn(Map<String, dynamic> duration, BuildContext context) {
  List<dynamic> daysList = duration['days'];
  List<String> days = [];
  //loop through days and convert to DateTime String to only day name
  for (var day in daysList) {
    if (day != 'Monday' &&
        day != 'Tuesday' &&
        day != 'Wednesday' &&
        day != 'Thursday' &&
        day != 'Friday' &&
        day != 'Saturday' &&
        day != 'Sunday') {
      day = DateFormat('EEEE').format(DateTime.parse(day));
      days.add(day);
    } else {
      days.add(day);
    }
  }
  List<dynamic> times = duration['times'];
  // check days and get the nearest day
  final now = DateTime.now();
  final todayName = DateFormat('EEEE').format(now);
  final tomorrowName =
      DateFormat('EEEE').format(now.add(const Duration(days: 1))).toString();
  String day = '';
  for (var val in days) {
    if (val == todayName) {
      day = 'Today';
      break;
    } else if (val == tomorrowName) {
      day = 'Tomorrow';
      break;
    } else {
      day = val;
    }
  }
  // get earliest time from list
  TimeOfDay time = TimeOfDay(
      hour: int.parse(times[0].split(':')[0]),
      minute: int.parse(times[0].split(':')[1]));
  final timeNow = TimeOfDay.now();
  //convert String to TimeOfDay with format hh:mm a
  for (var val in times) {
    final timeOfDay = TimeOfDay(
        hour: int.parse(val.split(':')[0]),
        minute: int.parse(val.split(':')[1]));
    //get find difference between time now and time of day
    final difference = timeOfDay.toDateTime().difference(timeNow.toDateTime());
    final difference2 = time.toDateTime().difference(timeNow.toDateTime());
    if (!difference.isNegative && (difference.inHours < difference2.inHours)) {
      time = timeOfDay;
      break;
    }
  }
  return 'Due in $day at ${time.format(context)}';
}

String getDueIn(TimeOfDay time) {
  // return due in hours, minutes or seconds or time of day
  final now = DateTime.now();
  final timeOfDay = time.toDateTime();
  final difference = timeOfDay.difference(now);
  if (difference.inDays > 0 && difference.inDays < 2) {
    return "Due in ${difference.inDays} days";
  } else if (difference.inHours > 0 && difference.inHours < 24) {
    return "Due in ${difference.inHours} hours";
  } else if (difference.inMinutes > 0 && difference.inMinutes < 60) {
    return "Due in ${difference.inMinutes} minutes";
  } else if (difference.inSeconds > 0 && difference.inSeconds < 60) {
    return "Due in ${difference.inSeconds} seconds";
  } else if (difference.inSeconds == 0) {
    return "Due now";
  } else {
    //return date with format EEE, MMM d, yyyy
    return "Due in ${DateFormat('EEE, MMM d, yyyy').format(timeOfDay)}";
  }
}

String getDay(String date) {
  if (date != 'Monday' &&
      date != 'Tuesday' &&
      date != 'Wednesday' &&
      date != 'Thursday' &&
      date != 'Friday' &&
      date != 'Saturday' &&
      date != 'Sunday') {
    date = DateFormat('EEEE').format(DateTime.parse(date));
    //return first 3 letters of day
    return date.substring(0, 3);
  } else {
    return date.substring(0, 3);
  }
}

double calculateDistance(
    {required double lat1,
    required double lon1,
    required double lat2,
    required double lon2}) {
  //convert latitudes and longitudes to radians
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);
  //convert latitudes to radians
  lat1 = _toRadians(lat1);
  lat2 = _toRadians(lat2);
  //calculate distance
  double a =
      pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
  double rad = 6371;
  double c = 2 * asin(sqrt(a));
  print('distance=====================${rad * c}');
  return rad * c;
}

double _toRadians(double lat1) {
  return lat1 * pi / 180;
}

Future<bool> getLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return true;
}
