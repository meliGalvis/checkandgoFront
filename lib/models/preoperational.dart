class Preoperational {
  final int id;
  final String type;

  Preoperational({
    required this.id,
    required this.type,
  });

  factory Preoperational.fromJson(Map<String, dynamic> json) {
    return Preoperational(
      id: json['id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}