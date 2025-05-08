import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/viewModel/auth_view_model.dart';
import 'login_require_screen.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<AuthViewModel, bool>(
      selector: (context, authProvider) => authProvider.isLoggedIn,
      builder: (context, isLoggedIn, child) {
        if (!isLoggedIn) {
          return const RequireLoginScreen();
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Favorites")),
          body: Center(child: Text("Danh sách yêu thích")),
        );
      },
    );
  }
}
