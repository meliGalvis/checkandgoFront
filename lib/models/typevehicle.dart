class TypeVehicle {
  final int id;
  final String name;
  final int status;

  TypeVehicle({
    required this.id,
    required this.name,
    required this.status,
  });

  factory TypeVehicle.fromJson(Map<String, dynamic> json) {
    return TypeVehicle(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}