import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/suscription.dart';

class SuscriptionController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<Suscription>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'suscription'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => Suscription.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Suscripciones');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(Suscription sus) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sus.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(Suscription sus) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'suscription',
        'data': {
          'datestar': sus.dateStart.toIso8601String(),
          'fkuser': sus.fkuser,
          'dateend': sus.dateEnd.toIso8601String(),
        },
        'where': 'id = ${sus.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'suscription',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}