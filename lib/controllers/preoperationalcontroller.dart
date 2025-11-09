import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/preoperational.dart';

class PreoperationalController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Preoperational>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'preoperational'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Preoperational.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Preoperational');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Preoperational pre) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pre.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Preoperational pre) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'preoperational',
        'data': {'type': pre.type},
        'where': 'id = ${pre.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'preoperational',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}