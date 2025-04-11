import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://crudcrud.com/api/44081dae2c814d60a16533038549ba0f/users';


  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }


  Future<void> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar usuário');
    }
  }


  Future<void> updateUser(String id, String name, String email) async {
    final url = '$baseUrl/$id';

    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar usuário');
    }
  }


  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao excluir usuário');
    }
  }
}
