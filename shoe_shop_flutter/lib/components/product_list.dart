import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_flutter/components/pagination.dart';
import 'package:shoe_shop_flutter/data/viewModel/favorite_view_model.dart';
import 'package:shoe_shop_flutter/utils/dialog_auth.dart';
import '../data/model/product_model.dart';
import '../data/viewModel/auth_view_model.dart';

class ProductList extends StatefulWidget {
  final Stream<List<Product>> productStream;
  final Stream<int> totalPagesStream;
  final int currentPage;
  final Function(int) onPageChanged;

  const ProductList({
    super.key,
    required this.productStream,
    required this.totalPagesStream,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final FavoriteViewModel _favoriteViewModel;
  late final AuthViewModel _authViewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
        _favoriteViewModel = Provider.of<FavoriteViewModel>(context, listen: false);

        if (_authViewModel.isLoggedIn && _authViewModel.userId != null) {
          _favoriteViewModel.fetchFavorites(int.parse(_authViewModel.userId!));
        }

        print("Đã gọi thành công");
      } catch (e, stack) {
        print("❌ Lỗi xảy ra trong addPostFrameCallback: $e");
        print("Stacktrace: $stack");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: widget.productStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No products available"));
        } else {
          List<Product> products = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      id: product.id,
                      name: product.name,
                      image: product.image,
                      price: product.price,
                    );
                  },
                ),
              ),
              // Hiển thị phân trang
              StreamBuilder<int>(
                stream: widget.totalPagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final totalPages = snapshot.data;
                  if (totalPages == null || totalPages <= 1) {
                    return const SizedBox.shrink();
                  }

                  return Pagination(
                    currentPage: widget.currentPage,
                    totalPages: totalPages,
                    onPageChanged: widget.onPageChanged,
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final int id;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.id,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final AuthViewModel _authViewModel;
  late final FavoriteViewModel _favoriteViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _favoriteViewModel = Provider.of<FavoriteViewModel>(context, listen: false);

    });
  }

  void handleFavoriteTap(BuildContext context) {
    if (!_authViewModel.isLoggedIn) {
      DialogAuth.showLoginRequiredDialog(context);
      return;
    }

    final userId = int.parse(_authViewModel.userId!);

    print("Check $userId , ${widget.id}");
    _favoriteViewModel.toggleFavorite(userId, widget.id);
  }

  void handleAddToCartTap(BuildContext context) {
    if (!_authViewModel.isLoggedIn) {
      DialogAuth.showLoginRequiredDialog(context);
      return;
    }
    print("Add to cart: ${widget.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteViewModel>(builder: (context, favoriteVM, _) {
      final isFavorite = favoriteVM.isFavorite(widget.id);

      return Card(
        elevation: 4,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image, color: Colors.redAccent),
                  fadeInDuration: Duration(milliseconds: 300),
                  fit: BoxFit.cover,
                  height: 160,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "\$${widget.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: GestureDetector(
                onTap: () => handleFavoriteTap(context),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 26,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 15,
              child: GestureDetector(
                onTap: () => handleAddToCartTap(context),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
