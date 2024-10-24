import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double cornerRadius;

  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.cornerRadius = 40
  });

  // Function to change the lightness of a color
  Color changeLightness(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    final newHsl = hsl.withLightness(newLightness);
    return newHsl.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).canvasColor;

    // Adjust the colors based on the current theme
    Color darkerColor;
    Color lighterColor;

    // Check if the current theme is dark
    if (Theme.of(context).brightness == Brightness.dark) {
      darkerColor = changeLightness(primaryColor, 0.005);
      lighterColor = changeLightness(primaryColor, 0.010);
    } else {
      darkerColor = changeLightness(primaryColor, 0.000);
      lighterColor = changeLightness(primaryColor, -0.015);
    }

    return Center(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(width: 0.1, color: primaryColor),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [darkerColor, lighterColor],
            ),
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}