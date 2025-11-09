import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/typemaintenance.dart';

class TypeMaintenanceController {
  static const String baseUrl = 'http://10.0.2.2/index.php'; // Cambia según tu backend

  Future<List<TypeMaintenance>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'typemaintenance'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => TypeMaintenance.fromJson(json))
            .toList();
      } else {
        throw Exception('Error al obtener Tipos de Mantenimiento');
      }
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(TypeMaintenance tm) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tm.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(TypeMaintenance tm) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'typemaintenance',
        'data': {
          'name': tm.name,
          'description': tm.description,
          'status': tm.status,
        },
        'where': 'id = ${tm.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'typemaintenance',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}