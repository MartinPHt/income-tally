import 'package:flutter/material.dart';

import '../services/helpers.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double cornerRadius;
  final double borderThickness;
  final LinearGradient? gradient;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.cornerRadius = 40,
    this.borderThickness = 0.1,
    this.margin,
    this.padding,
    this.gradient,
    this.constraints,
    this.alignment = Alignment.center
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).canvasColor;

    // Adjust the colors based on the current theme
    Color darkerColor;
    Color lighterColor;

    // Check if the current theme is dark
    if (Theme.of(context).brightness == Brightness.dark) {
      darkerColor = AppColors.changeLightness(primaryColor, 0.005);
      lighterColor = AppColors.changeLightness(primaryColor, 0.010);
    } else {
      darkerColor = AppColors.changeLightness(primaryColor, 0.000);
      lighterColor = AppColors.changeLightness(primaryColor, -0.015);
    }

    return Container(
      alignment: alignment,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
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
    );
  }
}