import 'package:employee_detail_app/module/employee/bloc/employee_bloc.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_event.dart';
import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:employee_detail_app/module/employee/widget/custom_text_field.dart';
import 'package:employee_detail_app/module/employee/widget/select_role_sheet.dart';
import 'package:employee_detail_app/module/home/widget/custom_date_picker_dialog.dart';
import 'package:employee_detail_app/module/home/widget/custom_snackbar.dart';
import 'package:employee_detail_app/utils/app_assets.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_functions.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:employee_detail_app/widgets/common_button.dart';
import 'package:employee_detail_app/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddEditEmployeePage extends StatefulWidget {
  final Employee? employee;
  const AddEditEmployeePage({super.key, this.employee});

  @override
  State<AddEditEmployeePage> createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends State<AddEditEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  @override
  void initState() {
    if (widget.employee != null) {
      nameController.text = widget.employee!.name;
      roleController.text = widget.employee!.role;
      fromDateController.text = widget.employee!.fromDate;
      toDateController.text = widget.employee!.toDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunctions.closeKeyBoard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 16.w,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
              widget.employee != null
                  ? AppStrings.editEmployeeDetails
                  : AppStrings.addEmployeeDetails,
              style: AppStyles.textStyle18),
          actions: [
            if (widget.employee != null)
              IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                  onPressed: () {
                    // Delete employee
                    context
                        .read<EmployeeBloc>()
                        .add(DeleteEmployee(widget.employee?.id ?? 0));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      content: const CustomSnackBar(),
                    ));
                  },
                  icon: SvgImage(
                    image: AppAssets.deleteThin,
                    height: 24.w,
                    width: 25.w,
                  ))
          ],
        ),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //name
                  Padding(
                    padding: EdgeInsets.only(bottom: 23.h),
                    child: CustomTextField(
                      controller: nameController,
                      hintText: AppStrings.nameHintText,
                      prefixIcon: AppAssets.person,
                      validator: (value) =>
                          value!.isEmpty ? AppStrings.nameEmptyMess : null,
                    ),
                  ),
                  //role
                  Padding(
                    padding: EdgeInsets.only(bottom: 23.h),
                    child: CustomTextField(
                      controller: roleController,
                      hintText: AppStrings.roleHintText,
                      prefixIcon: AppAssets.role,
                      isSuffixIcon: true,
                      enabled: false,
                      onTap: () {
                        showSelectRoleSheet(context, setRole);
                      },
                      validator: (value) =>
                          value!.isEmpty ? AppStrings.roleEmptyMess : null,
                    ),
                  ),
                  //from and to date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: AppStrings.todayText,
                          controller: fromDateController,
                          enabled: false,
                          prefixIcon: AppAssets.calender,
                          onTap: () async {
                            await showDialog<Map<String, DateTime>>(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDatePickerDialog(
                                  onPressed: setFromDate,
                                  selectedString: fromDateController.text,
                                );
                              },
                            );
                          },
                          validator: (value) =>
                              value!.isEmpty ? AppStrings.fromDateMess : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: toDateController,
                          hintText: AppStrings.noDate,
                          enabled: false,
                          prefixIcon: AppAssets.calender,
                          onTap: () async {
                            if (fromDateController.text.isNotEmpty) {
                              await showDialog<Map<String, DateTime>>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDatePickerDialog(
                                    onPressed: setToDate,
                                    isFromDate: false,
                                    fromdate: fromDateController.text.isNotEmpty
                                        ? AppFunctions.parseDate(
                                            fromDateController.text)
                                        : null,
                                    selectedString: toDateController.text,
                                  );
                                },
                              );
                            } else {
                              showTopSnackBar(context, AppStrings.fromDateMess);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          //floating footer
          Positioned(
            bottom: 12,
            right: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // thickness: 2.h,
                  height: 2.sp,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //cancel
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: CommonButton(
                          text: AppStrings.cancelText,
                          buttonColor: AppColors.primaryColor.withOpacity(.1),
                          textColor: AppColors.primaryColor,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      //save
                      CommonButton(
                          text: AppStrings.saveText,
                          onTap: () {
                            if (isValid()) {
                              final employee = Employee(
                                id: widget.employee?.id,
                                name: nameController.text,
                                role: roleController.text,
                                fromDate: fromDateController.text,
                                toDate: toDateController.text,
                              );
                              if (widget.employee != null) {
                                // Update employee
                                context
                                    .read<EmployeeBloc>()
                                    .add(UpdateEmployee(employee));
                              } else {
                                // Add employee
                                context
                                    .read<EmployeeBloc>()
                                    .add(AddEmployee(employee));
                              }
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void setRole(String role) {
    if (role.isNotEmpty) {
      roleController.text = role;
    }
  }

  void setFromDate(String fromDate) {
    if (fromDate.isNotEmpty) {
      fromDateController.text = fromDate;
    }
  }

  void setToDate(String toDate) {
    if (toDate.isNotEmpty) {
      toDateController.text = toDate;
    }
  }

  bool isValid() {
    if (nameController.text.isEmpty) {
      showTopSnackBar(context, AppStrings.nameEmptyMess);
      return false;
    } else if (roleController.text.isEmpty) {
      showTopSnackBar(context, AppStrings.roleEmptyMess);
      return false;
    } else if (fromDateController.text.isEmpty) {
      showTopSnackBar(context, AppStrings.fromDateMess);
      return false;
    } else {
      return true;
    }
  }

  void showTopSnackBar(BuildContext context, String message) {
    // Custom SnackBar at the top
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: AppStyles.textStyle12.copyWith(fontSize: 15),
        )));
  }
}
