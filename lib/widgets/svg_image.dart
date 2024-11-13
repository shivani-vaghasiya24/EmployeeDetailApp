import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  const SvgImage(
      {super.key, required this.image, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      height: height,
      width: width,

      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      // semanticsLabel: 'A red up arrow'
    );
    ;
  }
}
