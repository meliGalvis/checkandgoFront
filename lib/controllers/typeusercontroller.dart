import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/typeuser.dart';

class TypeUserController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<TypeUser>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'typeuser'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((json) => TypeUser.fromJson(json))
            .toList();
      }
      throw Exception('Error al obtener Tipo de Usuarios');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }
}