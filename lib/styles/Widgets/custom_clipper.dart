import 'package:flutter/material.dart';

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Top Left corner]
    var secondControlPoint = const Offset(0, 0);
    var secondEndPoint = Offset(width * .2, height * .3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    /// [Left Middle]
    var fifthControlPoint = Offset(width * .3, height * .5);
    var fiftEndPoint = Offset(width * .23, height * .6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fiftEndPoint.dx, fiftEndPoint.dy);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LogoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    path.lineTo(71.3 * xScaling, 24.6 * yScaling);
    path.cubicTo(
      77 * xScaling,
      29.5 * yScaling,
      80.8 * xScaling,
      36.7 * yScaling,
      82.4 * xScaling,
      44.5 * yScaling,
    );
    path.cubicTo(
      84 * xScaling,
      52.2 * yScaling,
      83.4 * xScaling,
      60.6 * yScaling,
      80.3 * xScaling,
      68.9 * yScaling,
    );
    path.cubicTo(
      77.1 * xScaling,
      77.2 * yScaling,
      71.6 * xScaling,
      85.5 * yScaling,
      64.1 * xScaling,
      88 * yScaling,
    );
    path.cubicTo(
      56.6 * xScaling,
      90.4 * yScaling,
      47.2 * xScaling,
      87 * yScaling,
      38 * xScaling,
      83.5 * yScaling,
    );
    path.cubicTo(
      28.8 * xScaling,
      80 * yScaling,
      19.8 * xScaling,
      76.3 * yScaling,
      14.299999999999997 * xScaling,
      69.3 * yScaling,
    );
    path.cubicTo(
      8.700000000000003 * xScaling,
      62.4 * yScaling,
      6.600000000000001 * xScaling,
      52.2 * yScaling,
      8.799999999999997 * xScaling,
      43.3 * yScaling,
    );
    path.cubicTo(
      11.100000000000001 * xScaling,
      34.4 * yScaling,
      17.700000000000003 * xScaling,
      26.9 * yScaling,
      25.3 * xScaling,
      22.4 * yScaling,
    );
    path.cubicTo(
      32.9 * xScaling,
      17.799999999999997 * yScaling,
      41.4 * xScaling,
      16.200000000000003 * yScaling,
      49.6 * xScaling,
      16.700000000000003 * yScaling,
    );
    path.cubicTo(
      57.7 * xScaling,
      17.200000000000003 * yScaling,
      65.5 * xScaling,
      19.8 * yScaling,
      71.3 * xScaling,
      24.6 * yScaling,
    );
    path.cubicTo(
      71.3 * xScaling,
      24.6 * yScaling,
      71.3 * xScaling,
      24.6 * yScaling,
      71.3 * xScaling,
      24.6 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
