import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserController {
  static const String baseUrl = 'http://10.0.2.2/index.php';

  Future<List<User>> fetchAll() async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'users'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List).map((json) => User.fromJson(json)).toList();
      }
      throw Exception('Error al obtener usuarios');
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<User?> fetchById(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=select'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'table': 'users', 'where': 'id = $id'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] && data['data'].isNotEmpty) {
        return User.fromJson(data['data'][0]);
      }
      return null;
    } else {
      throw Exception('Error en respuesta del servidor');
    }
  }

  Future<dynamic> insert(User user, String password) async {
    final userData = user.toJson();
    userData['password'] = password; // Sin hashear, backend debe hashear

    final response = await http.post(
      Uri.parse('$baseUrl?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> update(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'users',
        'data': {
          'name': user.name,
          'email': user.email,
          'fktypeuser': user.fktypeuser,
          'status': user.status,
        },
        'where': 'id = ${user.id}',
      }),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl?action=delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'table': 'users',
        'where': 'id = $id',
      }),
    );
    return jsonDecode(response.body);
  }
}