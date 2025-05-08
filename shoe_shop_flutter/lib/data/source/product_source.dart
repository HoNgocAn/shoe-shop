import 'dart:convert';
import "package:http/http.dart" as http;
import '../../constants/app_constants.dart';
import '../model/product_model.dart';
import '../model/product_page_model.dart';

abstract class DataSource {
  Future<ProductPage?> getProductList(int page);
}
class ProductSource implements DataSource {
  @override
  Future<ProductPage?> getProductList(int page) async {
    try {
      final String url =
          '${AppConstants.baseUrl}${AppConstants.productListEndpoint}?page=$page';
      final uri = Uri.parse(url);
      final rs = await http.get(uri);

      if (rs.statusCode == 200) {
        final bodyContent = utf8.decode(rs.bodyBytes);
        var productWrapper = jsonDecode(bodyContent) as Map;

        var productList = productWrapper['DT']['products'] as List;
        int totalPages = productWrapper['DT']['totalPages'];

        List<Product> products =
        productList.map((product) => Product.fromMap(product)).toList();

        return ProductPage(products: products, totalPages: totalPages);
      } else {
        print('Failed to load products with status code: ${rs.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }
}