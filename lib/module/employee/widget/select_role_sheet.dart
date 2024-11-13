import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_constants.dart';
import 'package:employee_detail_app/utils/app_functions.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSelectRoleSheet(BuildContext context, Function(String) onPressed) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: AppConstants.roleList.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  popScreen(context);
                  onPressed(AppConstants.roleList[index]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      AppConstants.roleList[index],
                      style: AppStyles.textStyle16
                          .copyWith(color: AppColors.textColor),
                    ),
                  ),
                ),
              ),
              //divider
              if (index < AppConstants.roleList.length - 1)
                Container(
                  height: 1.h,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.dividerColor,
                )
            ],
          );
        },
      );
    },
  );
}
