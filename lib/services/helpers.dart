import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse
  };
}

class AppColors {
  static final AppColors instance = AppColors._internal();

  factory AppColors() {
    return instance;
  }

  AppColors._internal();

  final Color backgroundPurple = const Color(0xffeee4f8);
  final Color backgroundBlue = const Color(0xffdfe0f3);

  // Function to change the lightness of a color
  Color changeLightness(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    final newHsl = hsl.withLightness(newLightness);
    return newHsl.toColor();
  }
}