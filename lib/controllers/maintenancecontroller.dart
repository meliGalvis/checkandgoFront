import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/maintenance.dart';

class MaintenanceController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Maintenance>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'maintenance'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Maintenance.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener mantenimientos');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<List<Maintenance>> fetchByVehicle(int vehicleId) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'maintenance',
        'where': 'fkvehicle = $vehicleId',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Maintenance.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener mantenimientos por vehículo');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Maintenance maintenance) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(maintenance.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Maintenance maintenance) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'maintenance',
        'data': {
          'fkvehicle': maintenance.fkvehicle,
          'fktypemaintenance': maintenance.fktypemaintenance,
          'date': maintenance.date,
          'milage': maintenance.milage,
          'description': maintenance.description,
          'totalcost': maintenance.totalcost,
        },
        'where': 'id = ${maintenance.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'maintenance',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}
