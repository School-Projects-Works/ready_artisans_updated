

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 TextStyle normalText ({
  Color color = Colors.black,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w400,
   decoration = TextDecoration.none,
}) => GoogleFonts.openSans(
  color: color,
  fontSize: fontSize,
  fontWeight: fontWeight,
  decoration: decoration,
);
