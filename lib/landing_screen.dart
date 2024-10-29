import 'package:care_connect/loginform.dart';
import 'package:flutter/material.dart';

import 'registration.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Care Connect",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              _buildButton(
                context,
                "Login",
                Icons.login,
                Colors.teal[700],
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                ),
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                "Register",
                Icons.app_registration,
                Colors.orangeAccent,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationForm()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating a reusable button
  Widget _buildButton(BuildContext context, String label, IconData icon,
      Color? color, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
