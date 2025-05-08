import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/viewModel/auth_view_model.dart';
import '../routes/app_routes.dart';
import 'login_screen.dart'; // Giả sử bạn đang sử dụng Provider để quản lý trạng thái đăng nhập

class RequireLoginScreen extends StatelessWidget {
  const RequireLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    if (!authProvider.isLoggedIn) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Colors.deepPurpleAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Access Denied",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  "You must be logged in to access this page.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 160,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.login,
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: const Center(child: Text("Logged in")),
    );
  }
}