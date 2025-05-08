import 'dart:async';

import '../model/product_model.dart';
import '../model/product_page_model.dart';
import '../repository/product_repository.dart';


class ProductViewModel {
  final ProductRepository repository;

  final StreamController<List<Product>> productStream = StreamController<List<Product>>();
  final StreamController<int> totalPagesStream = StreamController<int>();

  ProductViewModel({required this.repository});

  Future<void> loadProductData({required int page}) async {
    try {

      ProductPage? productPage = await repository.getProductList(page);

      if (productPage != null) {

        productStream.add(productPage.products);

        totalPagesStream.add(productPage.totalPages);
      } else {
        productStream.add([]);
        totalPagesStream.add(0);
      }
    } catch (error) {
      productStream.addError(error);
      totalPagesStream.addError(error);
    }
  }

  void dispose() {
    productStream.close();
    totalPagesStream.close();
  }
}