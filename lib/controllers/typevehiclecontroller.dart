import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/typevehicle.dart';

class TypeVehicleController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<TypeVehicle>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'typevehicle'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => TypeVehicle.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Tipos de Vehículos');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(TypeVehicle tv) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tv.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(TypeVehicle tv) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'typevehicle',
        'data': {
          'name': tv.name,
          'status': tv.status,
        },
        'where': 'id = ${tv.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'typevehicle',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}