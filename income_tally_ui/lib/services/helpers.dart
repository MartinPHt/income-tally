import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse
  };
}

abstract class AppColors {
  static const Color backgroundPurple = Color(0xffeee4f8);
  static const Color backgroundBlue = Color(0xffdfe0f3);
  static const Color contentColorPurple = Color(0xffd68df3);
  static const Color contentColorBlue = Color(0xff7ca5f1);
  static const Color mainGridLineColor = Color(0xffbfbfbf);
  static const Color textColor = Color(0xff424242);

  // Function to change the lightness of a color
  static Color changeLightness(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    final newHsl = hsl.withLightness(newLightness);
    return newHsl.toColor();
  }
}

abstract class ChartHelper {
  //static fields
  static List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  static List<String> monthsShortened = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
}

abstract class AppStyles {
  static const lineChartHeadersStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    color: AppColors.textColor,
  );
}

abstract class StringFormatter {
  static String formatDateToDMY(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
  }
}