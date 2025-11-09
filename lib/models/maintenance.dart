class Maintenance {
  final int id;
  final int fkvehicle;
  final int fktypemaintenance;
  final String date;
  final int milage;
  final String description;
  final double totalcost;

  Maintenance({
    required this.id,
    required this.fkvehicle,
    required this.fktypemaintenance,
    required this.date,
    required this.milage,
    required this.description,
    required this.totalcost,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
    id: json['id'],
    fkvehicle: json['fkvehicle'],
    fktypemaintenance: json['fktypemaintenance'],
    date: json['date'],
    milage: json['milage'],
    description: json['description'],
    totalcost: (json['totalcost'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fkvehicle': fkvehicle,
      'fktypemaintenance': fktypemaintenance,
      'date': date,
      'milage': milage,
      'description': description,
      'totalcost': totalcost,
    };
  }
}