import 'package:flutter/material.dart';

extension DarkMode on BuildContext {
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

class ColorMode {
  final Color light;
  final Color dark;

  Color color(context, {bool invert = false}) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return invert
        ? brightness != Brightness.dark
            ? dark
            : light
        : brightness == Brightness.dark
            ? dark
            : light;
  }

  ColorMode({required this.dark, required this.light});
}

class CustomColors {
  ColorMode background =
      ColorMode(dark: Colors.black45, light: const Color(0xFFf0f0ed));
  ColorMode text =
      ColorMode(dark: Colors.grey, light: const Color(0xFF0E0E0D));
  ColorMode heading =
      ColorMode(dark: const Color(0XFFFEFEFE), light: const Color(0xFF010101));
}
