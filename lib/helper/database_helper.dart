import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:hive/hive.dart';

class DatabaseHelper {
  static const String _boxName = 'employees';
  static const String _metadataBoxName = 'metadata'; // New box for metadata
  static const String _idKey = 'lastUsedId'; // Key to store last used ID

  // Insert employee
  Future<void> insertEmployee(Employee employee,
      {bool fromRestore = false}) async {
    final box = await Hive.openBox<Employee>(_boxName);
    final metadataBox = await Hive.openBox(_metadataBoxName);
    if (fromRestore || employee.id != null) {
      await box.put(employee.id, employee);
    } else {
      // Generate new unique ID
      final int newId = await _generateNewId(metadataBox);
      final newEmployee = employee.copyWith(id: newId);
      await box.put(newId, newEmployee); // Store employee with new ID
    }
  }

  // Method to generate a new unique ID
  Future<int> _generateNewId(Box metadataBox) async {
    // Retrieve the last used ID, or default to 0 if not set
    int lastId = metadataBox.get(_idKey, defaultValue: 0) as int;

    // Increment the last ID for the new employee
    lastId += 1;

    // Store the updated ID back in the metadata box
    await metadataBox.put(_idKey, lastId);

    return lastId; // Return the new ID
  }

  // Fetch all employees
  Future<List<Employee>> fetchEmployees() async {
    final box = await Hive.openBox<Employee>(_boxName);
    return box.values.toList(); // Get all employees
  }

  // Update employee
  Future<void> updateEmployee(Employee employee) async {
    final box = await Hive.openBox<Employee>(_boxName);
    if (employee.id != null) {
      await box.put(employee.id!, employee); // Update employee at index
    }
  }

  // Delete employee
  Future<void> deleteEmployee(int id) async {
    final box = await Hive.openBox<Employee>(_boxName);
    await box.delete(id); //
    // // Loop through the box to find the employee with the matching ID
    // final index =
    //     box.values.toList().indexWhere((employee) => employee.id == id);

    // if (index != -1) {
    //   await box.deleteAt(index); // Delete the employee by index
    // } else {
    //   print("Employee with ID $id not found.");
    // }
  }

  // Fetch employee by ID (Hive doesn't have a direct way to query by ID, so we match manually)
  Future<Employee?> getEmployeeById(int id) async {
    final box = await Hive.openBox<Employee>(_boxName);
    return box.get(id);
    // final index =
    //     box.values.toList().indexWhere((employee) => employee.id == id);
    // Employee? employee;
    // if (index != -1) {
    //   employee = box.get(index);
    // }
    // if (employee != null) {
    //   return employee; // Return the employee if found
    // } else {
    //   return null; // Return null if not found
    // }
  }
}
