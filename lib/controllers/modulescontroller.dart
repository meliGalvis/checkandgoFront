import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/modules.dart';

class ModulesController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Modules>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'modules'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Modules.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Módulos');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Modules module) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(module.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Modules module) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'modules',
        'data': {
          'name': module.name,
        },
        'where': 'id = ${module.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'modules',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}