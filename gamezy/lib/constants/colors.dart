import 'package:flutter/material.dart';

class ColorMode{
  final Color light;
  final Color dark;

  Color color(context){
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark?dark:light;
  }

  ColorMode({required this.dark, required this.light});
}
class CustomColors{
  ColorMode background = ColorMode(dark: Colors.black45, light: const Color(0xFFE7E7DF));
  ColorMode heading = ColorMode(dark: Colors.grey, light: const Color(0xFF0E0E0D));
  ColorMode text = ColorMode(dark: const Color(0XFFFEFEFE), light: const Color(0xFF010101));
}