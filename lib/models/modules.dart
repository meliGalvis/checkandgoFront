class Modules {
  final int id;
  final String name;

  Modules({
    required this.id,
    required this.name,
  });

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
