import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeDetailWidget extends StatelessWidget {
  final Employee employee;
  final bool isCurrentEmp;
  const EmployeeDetailWidget(
      {super.key, required this.employee, this.isCurrentEmp = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //name
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              employee.name.isNotEmpty ? employee.name : "N/A",
              style: AppStyles.textStyle16.copyWith(
                  color: AppColors.textColor, fontWeight: FontWeight.w500),
            ),
          ),
          //role
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              employee.role.isNotEmpty ? employee.role : "N/A",
              style: AppStyles.textStyle14.copyWith(
                  color: AppColors.hintTextColor, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              isCurrentEmp
                  ? employee.fromDate.isNotEmpty
                      ? '${employee.fromDate.split(" ").first} ${employee.fromDate.split(" ")[1]}, ${employee.fromDate.split(" ").last}'
                      : "N/A"
                  : "${employee.fromDate.isNotEmpty ? '${employee.fromDate.split(" ").first} ${employee.fromDate.split(" ")[1]}, ${employee.fromDate.split(" ").last}' : 'N/A'} - ${employee.toDate.isNotEmpty ? '${employee.toDate.split(" ").first} ${employee.toDate.split(" ")[1]}, ${employee.toDate.split(" ").last}' : 'N/A'}",
              style: AppStyles.textStyle12.copyWith(
                color: AppColors.hintTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
