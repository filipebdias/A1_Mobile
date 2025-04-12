import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_user_screen.dart';
import 'edit_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> futureUsers;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      futureUsers = apiService.getUsers();
    });
  }

  Future<void> _deleteUser(String id) async {
    await apiService.deleteUser(id);
    _loadUsers();
  }

  Future<void> _navigateToAddUser() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddUserScreen()),
    );
    if (result == true) _loadUsers();
  }

  Future<void> _navigateToEditUser(String userId, Map<String, dynamic> userData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(userId: userId, userData: userData),
      ),
    );
    if (result == true) _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Usuários'),
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Erro ao carregar usuários. Tente novamente.',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum usuário encontrado.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }

            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userId = user['id']?.toString();

                if (userId == null) {
                  return const ListTile(
                    title: Text('Usuário com ID inválido'),
                    subtitle: Text('Erro ao exibir este usuário.'),
                  );
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.deepPurple, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'] ?? 'Sem nome',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(user['email'] ?? 'Sem e-mail'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToEditUser(userId, user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(userId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddUser,
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
