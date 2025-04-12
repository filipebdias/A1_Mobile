import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://67f991bf094de2fe6ea1e8ef.mockapi.io/api/users';

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao carregar usuários: ${response.statusCode}');
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
      throw Exception('Erro ao criar usuário: ${response.statusCode}');
    }
  }

  Future<void> updateUser(dynamic id, String name, String email) async {
    if (id == null) {
      throw ArgumentError('ID do usuário não pode ser nulo.');
    }

    final url = '$baseUrl/${id.toString()}';

    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Erro ao atualizar usuário. Status: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(dynamic id) async {
    final String userId = id.toString();
    final response = await http.delete(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao excluir usuário: ${response.statusCode}');
    }
  }
}
