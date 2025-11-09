class Suscription {
  final int id;
  final DateTime dateStart;
  final int fkuser;
  final DateTime dateEnd;

  Suscription({
    required this.id,
    required this.dateStart,
    required this.fkuser,
    required this.dateEnd,
  });

  factory Suscription.fromJson(Map<String, dynamic> json) {
    return Suscription(
      id: json['id'],
      dateStart: DateTime.parse(json['datestar']),
      fkuser: json['fkuser'],
      dateEnd: DateTime.parse(json['dateend']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'datestar': dateStart.toIso8601String(),
        'fkuser': fkuser,
        'dateend': dateEnd.toIso8601String(),
      };
}