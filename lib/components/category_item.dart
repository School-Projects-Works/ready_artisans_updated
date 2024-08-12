import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/styles/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, this.categoryName, this.categoryImage});
  final String? categoryName;
  final String? categoryImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Container(
        alignment: Alignment.bottomLeft,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(categoryImage!),
            fit: BoxFit.fill,
          ),
        ),
        child: Chip(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            label: Text(
              categoryName!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}
