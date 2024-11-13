import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetImageWidget extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  const AssetImageWidget(
      {super.key, required this.image, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      width: width,
    );
    ;
  }
}
