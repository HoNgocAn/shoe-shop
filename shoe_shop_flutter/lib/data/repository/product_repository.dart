import '../model/product_page_model.dart';
import '../source/product_source.dart';

abstract interface class ProductRepository {
  Future<ProductPage?> getProductList(int page); // Lấy cả sản phẩm và tổng số trang
}

class ProductRepositoryImpl implements ProductRepository {

  final ProductSource _productSource;

  ProductRepositoryImpl(this._productSource);

  @override
  Future<ProductPage?> getProductList(int page) async {
    try {
      // Lấy dữ liệu từ ProductSource
      ProductPage? productPage = await _productSource.getProductList(page);

      // Nếu không có dữ liệu, trả về null
      if (productPage == null) {
        return null;
      }
      // Trả về đối tượng ProductPage chứa cả sản phẩm và tổng số trang
      return productPage;
    } catch (e) {
      print('Error occurred while fetching products: $e');
      return null;
    }
  }
}