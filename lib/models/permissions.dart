class Permissions {
  final int id;
  final String name;
  final int fkmodule;
  final int fktypeuser;

  Permissions({
    required this.id,
    required this.name,
    required this.fkmodule,
    required this.fktypeuser,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      id: json['id'],
      name: json['name'],
      fkmodule: json['fkmodule'],
      fktypeuser: json['fktypeuser'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fkmodule': fkmodule,
        'fktypeuser': fktypeuser,
      };
}