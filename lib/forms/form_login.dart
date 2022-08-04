import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.height;

    var path = Path();
    path.lineTo(0, height * .8);
    path.lineTo(width * 2, height);
    path.lineTo(width * 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
