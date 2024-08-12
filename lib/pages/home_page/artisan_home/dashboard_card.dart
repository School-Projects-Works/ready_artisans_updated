import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({super.key, this.title, this.icon, this.number});
  final String? title;
  final IconData? icon;
  final String? number;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 2)
          ]),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  number!,
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                CircleAvatar(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: secondaryColor),
                ))
              ],
            ),
            const Spacer(),
            Text(
              title!,
              style: normalText(
                  color: Colors.black54, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
