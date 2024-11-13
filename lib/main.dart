import 'package:employee_detail_app/helper/database_helper.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_bloc.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_event.dart';
import 'package:employee_detail_app/module/home/view/home_page.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_constants.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => EmployeeBloc(DatabaseHelper())..add(LoadEmployees()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(AppConstants.designWidth, AppConstants.designHeight), //
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
            fontFamily: "Roboto",
            useMaterial3: false,
            primaryColor: AppColors.primaryColor),
        home: const HomePage(),
      ),
    );
  }
}
