class TypeMaintenance {
  final int id;
  final String name;
  final String? description;
  final int status;

  TypeMaintenance({
    required this.id,
    required this.name,
    this.description,
    required this.status,
  });

  factory TypeMaintenance.fromJson(Map<String, dynamic> json) {
    return TypeMaintenance(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status,
      };
}