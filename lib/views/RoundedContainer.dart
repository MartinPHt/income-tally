import 'package:flutter/material.dart';

import '../models/Helpers.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double cornerRadius;
  final double borderThickness;
  final LinearGradient? gradient;

  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.cornerRadius = 40,
    this.borderThickness = 0.1,
    this.gradient
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).canvasColor;

    // Adjust the colors based on the current theme
    Color darkerColor;
    Color lighterColor;

    // Check if the current theme is dark
    if (Theme.of(context).brightness == Brightness.dark) {
      darkerColor = AppColors.instance.changeLightness(primaryColor, 0.005);
      lighterColor = AppColors.instance.changeLightness(primaryColor, 0.010);
    } else {
      darkerColor = AppColors.instance.changeLightness(primaryColor, 0.000);
      lighterColor = AppColors.instance.changeLightness(primaryColor, -0.015);
    }

    return Center(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: primaryColor,
          gradient: gradient ?? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [darkerColor, lighterColor],
          ),
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(width: borderThickness, color: primaryColor),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child
      ),
    );
  }
}