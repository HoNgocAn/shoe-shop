import 'dart:convert';
import '../../constants/app_constants.dart';
import "package:http/http.dart" as http;

import '../model/favorite_model.dart';


abstract class DataSource {
  Future<void> toggleFavorite(String token,int userId, int productId);
  Future<List<FavoriteItem>> getFavorites(String token, int userId);
}

class FavoriteSource implements DataSource {
  // Toggle sản phẩm yêu thích (Thêm nếu chưa có, Xóa nếu đã có)
  @override
  Future<void> toggleFavorite(String token, int userId, int productId) async {
    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.toggleFavoriteEndpoint}';
      final uri = Uri.parse(url);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Thêm token vào header
        },
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['EC'] == 0) {
          print('Toggle favorite successful');
        } else {
          print('Toggle favorite failed: ${body['EM']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }


  @override
  Future<List<FavoriteItem>> getFavorites(String token, int userId) async {
    try {
      final String url = '${AppConstants.baseUrl}${AppConstants.getFavoritesEndpoint}/$userId';
      final uri = Uri.parse(url);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Thêm token vào header
        },
      );

      if (response.statusCode == 200) {
        final bodyContent = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(bodyContent);

        if (data['EC'] == 0) {
          List<dynamic> favoritesList = data['DT'];
          return favoritesList.map((item) => FavoriteItem.fromMap(item)).toList();
        } else {
          print("Get favorites failed: ${data['EM']}");
          return [];
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }
}