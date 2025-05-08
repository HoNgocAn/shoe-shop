import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/viewModel/auth_view_model.dart';
import '../routes/app_routes.dart';
import '../utils/snack_bar.dart';
import '../utils/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reEnterPasswordController =  TextEditingController();

  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      try {
        final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

        final isSuccess = await authViewModel.register(
          _usernameController.text,
          _passwordController.text,
        );

        if (isSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.login,
          );
        } else {
          SnackBarUtil.showSnackBar(context, 'Create new account failed!', Colors.red);
        }
      } catch (e) {
        SnackBarUtil.showSnackBar(context, 'Error: $e', Colors.red);
      } finally {
        if (mounted) { // Kiểm tra widget còn tồn tại
          setState(() {
            isLoader = false;
          });
        }
      }
    }
  }

  final appValidator = AppValidator();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No screen to back"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 80.0),
                const Center(
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      "Create New Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.black87),
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                  _buildInputDecoration("Username", Icons.verified_user),
                  validator: appValidator.validateUser,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.black87),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Password", Icons.password),
                  validator: appValidator.validatePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _reEnterPasswordController,
                  style: const TextStyle(color: Colors.black87),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Re-enter password", Icons.password),
                  validator: (value) => appValidator.validateRePassword(value, _passwordController.text),
                  obscureText: true,
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoader ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF15900),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: isLoader
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.login,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xFFF15900), fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Colors.grey[100],
      filled: true,
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: const TextStyle(color: Colors.black87),
      suffixIcon: Icon(suffixIcon, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
