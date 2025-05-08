import 'package:shoe_shop_flutter/data/model/product_model.dart';

class FavoriteItem {
  final int id;
  final int userId;
  final int productId;
  final bool isFavorite;
  final Product? product;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.isFavorite,
    required this.product,
  });

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: (map['id'] ?? 0) as int,
      userId: (map['userId'] ?? 0) as int,
      productId: (map['productId'] ?? 0) as int,
      isFavorite: (map['isFavorite'] ?? false) as bool,
      product: map['Product'] != null ? Product.fromMap(map['Product']) : null,
    );
  }

  @override
  String toString() {
    return 'FavoriteItem{id: $id, userId: $userId, productId: $productId, isFavorite: $isFavorite, product: $product}';
  }
}