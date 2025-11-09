import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle.dart';

class VehicleController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Vehicle>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'vehicles'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List).map((json) => Vehicle.fromJson(json)).toList();
      }
      throw Exception('Error al obtener vehículos');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<List<Vehicle>> fetchByUser(int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'vehicles', 'where': 'fkuser = $userId'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List).map((json) => Vehicle.fromJson(json)).toList();
      }
      throw Exception('Error al obtener vehículos por usuario');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Vehicle vehicle) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Vehicle vehicle) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'vehicles',
        'data': {
          'name': vehicle.name,
          'fkuser': vehicle.fkuser,
          'fktypevehicle': vehicle.fktypevehicle,
          'status': vehicle.status,
        },
        'where': 'id = ${vehicle.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'vehicles', 'where': 'id = $id'}),
    );
    return jsonDecode(response.body);
  }
}