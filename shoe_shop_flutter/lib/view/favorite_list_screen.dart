import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_list.dart';
import '../data/viewModel/auth_view_model.dart';
import '../data/viewModel/favorite_view_model.dart';
import 'login_require_screen.dart';


class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<AuthViewModel, bool>(
      selector: (_, auth) => auth.isLoggedIn,
      builder: (context, isLoggedIn, _) {
        if (!isLoggedIn) {
          return const RequireLoginScreen();
        }

        return Consumer<FavoriteViewModel>(
          builder: (context, favoriteVM, _) {
            if (favoriteVM.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final favorites = favoriteVM.favoriteList
                .where((item) => item.isFavorite && item.product != null)
                .toList();

            if (favorites.isEmpty) {
              return const Center(child: Text("No favorite products yet."));
            }

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const Center(
                      child: Text(
                        "Wishlist",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final product = favorites[index].product!;

                          return ProductCard(
                            id: product.id,
                            name: product.name,
                            image: product.image,
                            price: product.price,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
