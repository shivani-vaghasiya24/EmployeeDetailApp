import 'package:employee_detail_app/module/employee/model/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database?> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'employee.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT, fromDate TEXT, toDate TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertEmployee(Employee employee) async {
    final db = await database;
    await db?.insert('employees', employee.toMap());
  }

  Future<List<Employee>> fetchEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('employees');
    print("List of fetched employee $maps");
    return List.generate(maps.length, (i) {
      return Employee(
        id: maps[i]['id'],
        name: maps[i]['name'],
        role: maps[i]['role'],
        fromDate: maps[i]['fromDate'],
        toDate: maps[i]['toDate'],
      );
    });
  }

  Future<void> updateEmployee(Employee employee) async {
    final db = await database;
    await db?.update(
      'employees',
      employee.toMap(),
      where: "id = ?",
      whereArgs: [employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db?.delete(
      'employees',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Fetch employee by ID
  Future<Employee?> getEmployeeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Employee.fromMap(maps.first);
    } else {
      return null; // Return null if no employee is found
    }
  }
}
