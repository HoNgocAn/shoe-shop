

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/favorite_model.dart';
import '../source/favorite_source.dart';

abstract interface class FavoriteRepository {
  Future<void> toggleFavorite( int userId, int productId);
  Future<List<FavoriteItem>> getFavoriteList( int userId);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteSource _favoriteSource;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  FavoriteRepositoryImpl(this._favoriteSource);

  @override
  Future<void> toggleFavorite( int userId, int productId) async {
    try {
      final accessToken = await _secureStorage.read(key: 'access_token');
      if (accessToken != null){
        await _favoriteSource.toggleFavorite(accessToken, userId, productId);
      }
    } catch (e) {
      print('Error occurred while toggling favorite: $e');
    }
  }

  @override
  Future<List<FavoriteItem>> getFavoriteList(int userId) async {
    try {
      final accessToken = await _secureStorage.read(key: 'access_token');
      if (accessToken != null){
        List<FavoriteItem> favorites = await _favoriteSource.getFavorites(accessToken, userId);
        return favorites;
      }
      return [];
    } catch (e) {
      print('Error occurred while fetching favorite list: $e');
      return [];
    }
  }
}