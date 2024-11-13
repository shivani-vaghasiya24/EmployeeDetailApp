import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? radius;
  final FontWeight? fontWeight;
  const CommonButton(
      {super.key,
      required this.text,
      this.textColor,
      this.buttonColor,
      this.onTap,
      this.width,
      this.height,
      this.radius,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40.h,
        width: width ?? 73.w,
        decoration: BoxDecoration(
            color: buttonColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(radius ?? 6.r)),
        child: Center(
          child: Text(
            text,
            style: AppStyles.textStyle14
                .copyWith(color: textColor, fontWeight: fontWeight),
          ),
        ),
      ),
    );
  }
}
