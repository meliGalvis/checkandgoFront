import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/permissions.dart';

class PermissionsController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Permissions>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'permissions'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Permissions.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Permisos');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Permissions perm) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(perm.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Permissions perm) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'permissions',
        'data': {
          'name': perm.name,
          'fkmodule': perm.fkmodule,
          'fktypeuser': perm.fktypeuser,
        },
        'where': 'id = ${perm.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'permissions',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}