class Employee {
  final int? id;
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  Employee(
      {this.id,
      required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});

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
