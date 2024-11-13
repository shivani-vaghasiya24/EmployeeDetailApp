import 'package:employee_detail_app/module/employee/bloc/employee_bloc.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_event.dart';
import 'package:employee_detail_app/utils/app_colors.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:employee_detail_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.deleteDataMessage,
          style: AppStyles.textStyle12.copyWith(fontSize: 15),
        ),
        InkWell(
          onTap: () {
            // Restore employee
            context.read<EmployeeBloc>().add(RestoreDeletedEmployee());
            // // Undo action to restore the dismissed item
            //     // setState(() {
            //     //   _dismissedText = null;
            //     // });
          },
          child: Text('Undo',
              style: AppStyles.textStyle12
                  .copyWith(fontSize: 15, color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}
