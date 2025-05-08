import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_flutter/data/viewModel/auth_view_model.dart';
import 'login_require_screen.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
          body: Center(child: Text("Danh sách giỏ hàng")),
        );
      },
    );
  }
}