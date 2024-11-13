import 'package:employee_detail_app/utils/app_assets.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:employee_detail_app/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final bool isSuffixIcon;
  final String? prefixIcon;
  final bool enabled;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.isSuffixIcon = false,
      this.enabled = true,
      this.onTap,
      this.controller,
      this.validator,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        style: AppStyles.textStyle16.copyWith(color: AppColors.textColor),
        onChanged: onChanged,
        autofocus: false,
        validator: validator,
        decoration: InputDecoration(
            enabled: enabled,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor, width: 1.sp),
              borderRadius: BorderRadius.circular(6.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor, width: 1.sp),
              borderRadius: BorderRadius.circular(6.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor, width: 1.sp),
              borderRadius: BorderRadius.circular(6.r),
            ),
            isDense: true,
            hintText: hintText,
            hintStyle:
                AppStyles.textStyle16.copyWith(color: AppColors.hintTextColor),
            suffixIcon: isSuffixIcon
                ? GestureDetector(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: const SvgImage(
                        image: AppAssets.dropDown,
                        // height: 24.w,
                        // width: 24.w,
                      ),
                    ))
                : null,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: SvgImage(
                      image: prefixIcon!,
                      height: 24.w,
                      width: 24.w,
                    ),
                  )
                : null,
            prefixIconConstraints:
                BoxConstraints(maxWidth: 44.w, maxHeight: 24, minHeight: 24),
            suffixIconConstraints:
                BoxConstraints(maxWidth: 40.w, maxHeight: 20, minHeight: 20)
            // suffixIcon: AssetImageWidget(
            //   image: AppAssets.person,
            // )
            ),
      ),
    );
  }
}
