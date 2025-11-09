class Vehicle {
  final int id;
  final String name;
  final int fkuser;
  final int fktypevehicle;
  final int status;

  Vehicle({
    required this.id,
    required this.name,
    required this.fkuser,
    required this.fktypevehicle,
    required this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json['id'],
    name: json['name'],
    fkuser: json['fkuser'],
    fktypevehicle: json['fktypevehicle'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fkuser': fkuser,
      'fktypevehicle': fktypevehicle,
      'status': status,
    };
  }
}