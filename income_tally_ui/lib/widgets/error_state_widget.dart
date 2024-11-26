import 'package:flutter/cupertino.dart';

class ErrorStateWidget extends StatelessWidget {
  final Image? image;
  final String? title;
  final String? text;
  final double imageHeight;
  final double imageWidth;

  const ErrorStateWidget({super.key, this.image, this.title, this.text, this.imageHeight = 100, this.imageWidth = 100});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 120, maxWidth: 120),
                child: SizedBox(width: imageWidth, height: imageHeight, child: image ?? Image.asset('lib/icons/unpluggedIcon.png')),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    title ?? 'Something went wrong',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(text ?? 'An error occurred while loading yor expenses',
                      style: const TextStyle(fontSize: 18)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
