import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  const AddEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final int id;

  const DeleteEmployee(this.id);

  @override
  List<Object> get props => [id];
}

class LoadEmployees extends EmployeeEvent {
  final bool isRefresh;

  const LoadEmployees({this.isRefresh = false});
}

class RestoreDeletedEmployee extends EmployeeEvent {}
