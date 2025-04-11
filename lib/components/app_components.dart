import '../models/user_model.dart';
import 'package:flutter/material.dart';

class AppComponents {
  // Campo de texto genérico
  static Widget customTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Campo de senha
  static Widget passwordField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = true,
    required VoidCallback toggleObscureText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: toggleObscureText,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Campo de confirmação de senha
  static Widget confirmPasswordField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = true,
    required VoidCallback toggleObscureText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: toggleObscureText,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Card de usuário
  static Widget userCard(UserModel user) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}








