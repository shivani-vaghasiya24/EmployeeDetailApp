import 'package:employee_detail_app/module/employee/bloc/employee_bloc.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_event.dart';
import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:employee_detail_app/module/employee/view/add_edit_employee_page.dart';
import 'package:employee_detail_app/module/home/widget/custom_snackbar.dart';
import 'package:employee_detail_app/module/home/widget/dismissible_icon.dart';
import 'package:employee_detail_app/module/home/widget/employee_detail_widget.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_functions.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employeeList;
  EmployeeList({super.key, required this.employeeList});

  List<Employee> currentEmployees = [];
  List<Employee> previousEmployees = [];

  void setEmployeeList() {
    currentEmployees = employeeList.where(
      (element) {
        return element.toDate.isEmpty ||
            element.toDate == AppStrings.noDate ||
            element.toDate == AppStrings.todayText ||
            (element.toDate != AppStrings.noDate &&
                element.toDate.isNotEmpty &&
                AppFunctions.parseDate(element.toDate).isAfter(DateTime.now()));
      },
    ).toList();
    previousEmployees = employeeList.where(
      (element) {
        return element.toDate != AppStrings.noDate &&
            element.toDate.isNotEmpty &&
            AppFunctions.parseDate(element.toDate).isBefore(DateTime.now());
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    setEmployeeList();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentEmployees.isNotEmpty)
              //current employee
              Container(
                  color: AppColors.borderColor,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    AppStrings.currentEmployees,
                    style: AppStyles.textStyle16.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  )),
            if (currentEmployees.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                itemCount: currentEmployees.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(currentEmployees[index].id.toString()),
                      // key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Delete employee
                        context.read<EmployeeBloc>().add(
                            DeleteEmployee(currentEmployees[index].id ?? 0));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            content: const CustomSnackBar(),
                            // Text(
                            //   AppStrings.deleteDataMessage,
                            //   style: AppStyles.textStyle12.copyWith(fontSize: 15),
                            // ),
                            // action: SnackBarAction(
                            //   label: 'Undo',
                            //   textColor: AppColors.primaryColor,
                            //   onPressed: () {
                            //     // // Undo action to restore the dismissed item
                            //     // setState(() {
                            //     //   _dismissedText = null;
                            //     // });
                            //   },
                            // ),
                          ),
                        );
                      },
                      background: const DismissibleIcon(),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEditEmployeePage(
                                        employee: currentEmployees[index],
                                      )));
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: EmployeeDetailWidget(
                            employee: currentEmployees[index],
                            isCurrentEmp: true,
                          ),
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 1.h,
                    width: double.infinity,
                    color: AppColors.dividerColor,
                  );
                },
              ),
            if (previousEmployees.isNotEmpty)
              //previous employee
              Container(
                  color: AppColors.borderColor,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    AppStrings.previousEmployees,
                    style: AppStyles.textStyle16.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  )),
            if (previousEmployees.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                itemCount: previousEmployees.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(previousEmployees[index].id.toString()),
                      // key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Delete employee
                        context.read<EmployeeBloc>().add(
                            DeleteEmployee(previousEmployees[index].id ?? 0));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          content: const CustomSnackBar(),
                        ));
                      },
                      background: const DismissibleIcon(),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEditEmployeePage(
                                        employee: previousEmployees[index],
                                      )));
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: EmployeeDetailWidget(
                            employee: previousEmployees[index],
                          ),
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 1.h,
                    width: double.infinity,
                    color: AppColors.dividerColor,
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
