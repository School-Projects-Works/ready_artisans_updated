import 'package:flutter/material.dart';
import 'package:ready_artisans/constant/functions.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';

import 'open_artisan/open_artisan.dart';

class ArtisanCard extends StatelessWidget {
  const ArtisanCard({super.key, this.artisan, this.isRated = false});
  final UserModel? artisan;
  final bool isRated;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        sendToPage(
            context,
            ArtisanDetailPage(
              artisan!.id,
            ));
      },
      child: Container(
          height: 180,
          width: isRated ? size.width * .9 : size.width * .46,
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: artisan!.image != null
                ? DecorationImage(
                    image: NetworkImage(artisan!.image!),
                    fit: BoxFit.fill,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Container(
              width: isRated ? size.width : size.width * .6,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      artisan!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          normalText(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      artisan!.artisanCategory!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    //rating
                    if (artisan!.rating != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            artisan!.rating!.toStringAsFixed(1),
                            style: normalText(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          for (int i = 0; i < artisan!.rating!.toInt(); i++)
                            const Icon(Icons.star,
                                color: secondaryColor, size: 15)
                        ],
                      )
                  ]))),
    );
  }
}
