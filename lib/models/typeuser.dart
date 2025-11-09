class TypeUser {
  final int id;
  final String name;

  TypeUser({
    required this.id,
    required this.name,
  });

  factory TypeUser.fromJson(Map<String, dynamic> json) {
    return TypeUser(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}