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
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            isDense: true,
            hintText: hintText,
            hintStyle:
                AppStyles.textStyle16.copyWith(color: AppColors.hintTextColor),
            suffixIcon: isSuffixIcon
                ? GestureDetector(
                    onTap: onTap,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SvgImage(
                        image: AppAssets.dropDown,
                        // height: 24.w,
                        // width: 24.w,
                      ),
                    ))
                : null,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SvgImage(
                      image: prefixIcon!,
                      height: 24,
                      width: 24,
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
                maxWidth: 44, maxHeight: 24, minHeight: 24),
            suffixIconConstraints:
                const BoxConstraints(maxWidth: 40, maxHeight: 20, minHeight: 20)
            // suffixIcon: AssetImageWidget(
            //   image: AppAssets.person,
            // )
            ),
      ),
    );
  }
}
