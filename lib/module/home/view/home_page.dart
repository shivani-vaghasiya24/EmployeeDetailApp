import 'package:employee_detail_app/module/employee/bloc/employee_bloc.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_state.dart';
import 'package:employee_detail_app/module/employee/view/add_edit_employee_page.dart';
import 'package:employee_detail_app/module/home/widget/employee_list.dart';
import 'package:employee_detail_app/module/home/widget/no_data_widget.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 16.w,
            elevation: 0,
            title: Text(AppStrings.employeeList, style: AppStyles.textStyle18)),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  EmployeeList(
                    employeeList: state.employees,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 80.h,
                      width: double.infinity,
                      color: AppColors.borderColor,
                      padding: EdgeInsets.only(top: 12.h, left: 16.w),
                      child: Text(AppStrings.swipeLeftToDelete,
                          style: AppStyles.textStyle12.copyWith(
                            fontSize: 15,
                            color: AppColors.hintTextColor,
                          )),
                    ),
                  )
                ],
              );
            } else if (state is EmployeeError) {
              return const NoDataWidget();
            } else {
              return const NoDataWidget();
            }
          },
        ),
        floatingActionButton: SizedBox(
          height: 50.h,
          width: 50.w,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEditEmployeePage()));
            },
            tooltip: 'Add Employee',
            child: const Icon(Icons.add),
          ),
        ));
    ;
  }
}
