import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormGeneric extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.height;

    var path = Path();
    path.lineTo(0, height * .6);
    path.lineTo(width * 5, height * .9);
    path.lineTo(width * 5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
