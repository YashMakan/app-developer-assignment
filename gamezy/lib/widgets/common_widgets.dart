import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GWidgets{
  static loader() {
    return Center(
        child: Lottie.asset(
          "assets/images/loader.json",
        ));
//    return Center(child: Image.asset("assets/images/loader.gif"));
  }
}