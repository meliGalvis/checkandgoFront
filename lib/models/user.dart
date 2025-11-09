class User {
  final int id;
  final String name;
  final String email;
  final int fktypeuser;
  final int status;
  // Si tienes password y otros campos, agrégalos aquí

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.fktypeuser,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      fktypeuser: json['fktypeuser'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'fktypeuser': fktypeuser,
      'status': status,
      // No agregues password aquí para evitar exponerla accidentalmente
    };
  }
}