import 'package:flutter/cupertino.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Start from bottom-left
   path.moveTo(0, size.height*.38);

    // Draw wave at the TOP
    path.quadraticBezierTo(
      size.width / 2,
    size.height*.25,       // peak
      size.width,
     size.height*.38,     // right end
    );

    // Go down to bottom-right
    path.lineTo(size.width, size.height);

    // Go across bottom
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
