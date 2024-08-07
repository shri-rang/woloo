import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageProvider extends StatelessWidget {
  final String? image;
  final double? widht;
  final double? height;
  final BoxFit boxFit;
  const CustomImageProvider(
      {super.key,
      this.image,
      this.height,
      this.widht,
      this.boxFit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return image!.startsWith("https:")
        ? Image.network(image!, height: height, width: widht, fit: boxFit)
        : image!.endsWith(".svg")
            ? SvgPicture.asset(
                image!,
                height: height,
                width: widht,
                fit: boxFit,
              )
            : Image.asset(image!, height: height, width: widht, fit: boxFit);
  }
}
