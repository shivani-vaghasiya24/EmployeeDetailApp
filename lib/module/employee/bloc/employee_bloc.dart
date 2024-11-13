import 'package:employee_detail_app/helper/database_helper.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_event.dart';
import 'package:employee_detail_app/module/employee/bloc/employee_state.dart';
import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:employee_detail_app/utils/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final DatabaseHelper databaseHelper;
  Employee? deletedEmployee;
  EmployeeBloc(this.databaseHelper) : super(EmployeeInitial()) {
    on<LoadEmployees>((event, emit) async {
      if (!event.isRefresh) {
        emit(EmployeeLoading());
      }
      try {
        final employees = await databaseHelper.fetchEmployees();
        if (employees.isNotEmpty) {
          emit(EmployeeLoaded(employees));
        } else {
          emit(const EmployeeError(AppStrings.noEmployeeMessage));
        }
      } catch (e) {
        emit(const EmployeeError(AppStrings.noEmployeeMessage));
      }
    });

    on<AddEmployee>((event, emit) async {
      print(
          "employee insert ${event.employee.name},${event.employee.role},${event.employee.name}");
      await databaseHelper.insertEmployee(event.employee);
      add(const LoadEmployees(
          isRefresh: true)); // Refresh employees list after Updation
    });

    on<UpdateEmployee>((event, emit) async {
      print(
          "employee insert ${event.employee.name},${event.employee.role},${event.employee.name}");
      await databaseHelper.updateEmployee(event.employee);
      //load the updated list
      add(const LoadEmployees(isRefresh: true));
      // Refresh employees list after Updation
    });

    on<DeleteEmployee>((event, emit) async {
      print("employee insert ${event.id}");
      final employee = await databaseHelper.getEmployeeById(event.id);
      if (employee != null) {
        deletedEmployee = employee;
        await databaseHelper.deleteEmployee(event.id);
        //load the updated list
        add(const LoadEmployees(
            isRefresh: true)); // Refresh employees list after deletion
      }
    });

    on<RestoreDeletedEmployee>((event, emit) async {
      if (deletedEmployee != null) {
        await databaseHelper.insertEmployee(deletedEmployee!,
            fromRestore: true); // Restore the deleted employee
        deletedEmployee = null; // Clear the temporary storage
        add(const LoadEmployees(isRefresh: true));
      }
    });
  }
}
