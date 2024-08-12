import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/functions.dart';
import '../../../../models/user_model.dart';
import '../../../../styles/app_colors.dart';

class OpenArtisanTop extends StatefulWidget {
  const OpenArtisanTop({super.key, required this.artisan});
  final UserModel artisan;

  @override
  State<OpenArtisanTop> createState() => _OpenArtisanTopState();
}

class _OpenArtisanTopState extends State<OpenArtisanTop>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  var breath = 0.0;
  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animationController!.addListener(() {
      setState(() {
        breath = _animationController!.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(children: [
            Container(
              height: 180,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.artisan.image!),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(children: [
                Text(
                  widget.artisan.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.artisan.email!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_android_outlined,
                      color: Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.artisan.phone!,
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${widget.artisan.address}, ${widget.artisan.city ?? ''}, ${widget.artisan.region ?? ''}',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                    widget.artisan.available ?? false
                        ? 'Available'
                        : 'Not Available',
                    style: GoogleFonts.roboto(
                        fontSize: 16 * breath,
                        fontWeight: FontWeight.w400,
                        color: widget.artisan.available ?? false
                            ? Colors.green
                            : Colors.red))
              ]),
            )
          ]),
          const Divider(
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    launchURL('tel:${widget.artisan.phone}');
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Call',
                    style: GoogleFonts.roboto(color: Colors.white),
                  )),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    launchURL(
                        'whatsapp://send?phone=+233${widget.artisan.phone!.substring(1)}&text=Hello ${widget.artisan.name}');
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.black,
                  ),
                  label: Text(
                    'WhatsApp',
                    style: GoogleFonts.roboto(color: Colors.black),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
