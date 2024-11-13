import 'package:hive/hive.dart';

part 'employee.g.dart'; // This is generated code by Hive.

@HiveType(typeId: 0) // Each class needs a unique typeId
class Employee {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final String fromDate;

  @HiveField(4)
  final String toDate;

  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.toDate,
  });

  // Convert a Employee into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      fromDate: map['fromDate'],
      toDate: map['toDate'],
    );
  }

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    String? fromDate,
    String? toDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}