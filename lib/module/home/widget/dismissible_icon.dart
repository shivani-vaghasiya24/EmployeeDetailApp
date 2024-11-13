import 'package:employee_detail_app/utils/app_assets.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/widgets/asset_image_widget.dart';
import 'package:employee_detail_app/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DismissibleIcon extends StatelessWidget {
  const DismissibleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.deleteColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const SvgImage(
          image: AppAssets.delete,
          height: 24,
          width: 24,
        )
        // Icon(
        //   Icons.delete,
        //   color: Colors.white,
        // ),
        );
  }
}
