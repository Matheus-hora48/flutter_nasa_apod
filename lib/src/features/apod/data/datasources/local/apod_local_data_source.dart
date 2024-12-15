import 'dart:convert';

import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApodLocalDataSource {
  Future<void> saveFavorite(ApodModel apod);
  Future<void> removeFavorite(ApodModel apod);
  Future<List<ApodModel>> getFavorites();
  Future<bool> isFavorite(ApodModel apod);
}

class ApodLocalDataSourceImpl implements ApodLocalDataSource {
  static const String favoritesKey = 'FAVORITES';

  @override
  Future<void> saveFavorite(ApodModel apod) async {
    final sp = await SharedPreferences.getInstance();

    final favorites = await getFavorites();
    final isAlreadyFavorite = await isFavorite(apod);
    if (!isAlreadyFavorite) {
      final updatedApod = apod.copyWith(isFavorite: true);
      favorites.add(updatedApod);
      final jsonString = jsonEncode(favorites.map((e) => e.toJson()).toList());
      await sp.setString(favoritesKey, jsonString);
    }
  }

  @override
  Future<void> removeFavorite(ApodModel apod) async {
    final sp = await SharedPreferences.getInstance();

    final favorites = await getFavorites();
    favorites.removeWhere((item) => item.url == apod.url);

    final jsonString = jsonEncode(favorites.map((e) => e.toJson()).toList());
    await sp.setString(favoritesKey, jsonString);
  }

  @override
  Future<List<ApodModel>> getFavorites() async {
    final sp = await SharedPreferences.getInstance();

    final jsonString = sp.getString(favoritesKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) {
        final apod = ApodModel.fromJson(e);
        return apod.copyWith(isFavorite: true);
      }).toList();
    }
    return [];
  }

  @override
  Future<bool> isFavorite(ApodModel apod) async {
    final favorites = await getFavorites();
    final isAlreadyFavorite = favorites.any((item) => item.url == apod.url);
    apod = apod.copyWith(isFavorite: isAlreadyFavorite);
    return isAlreadyFavorite;
  }
}
