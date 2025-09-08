import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/core/services/favorite_service.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/core/services/rating_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';

final passwordVisibilityProvider = StateProvider<bool>(
  (ref) => false,
); // holding value of password visibility

final selectedIndexProvider = StateProvider<int>(
  (ref) => 0,
); // holding  value for navigation bar

// handling favorite selection for single product

class FavoriteNotifier extends StateNotifier<Map<String, bool>> {
  FavoriteNotifier() : super({});

  Future<void> checkFavorite(String productId) async {
    final isFav = await FavoritesService().isFavorite(productId);
    state = {...state, productId: isFav};
  }

  void setFavorite(String productId, bool isFavorite) {
    state = {...state, productId: isFavorite};
  }

  bool isFavorite(String productId) {
    return state[productId] ?? false;
  }
}

final favoriteStatusProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, bool>>(
      (ref) => FavoriteNotifier(),
    );

//Rating Provider

class RatingNotifier extends StateNotifier<Map<String, int>> {
  RatingNotifier() : super({});

  final _ratingService = RatingService();

  Future<void> checkRating(String productId) async {
    final rating = await _ratingService.getRating(productId);
    state = {...state, productId: rating};
  }

  void setRating(String productId, int rating) {
    _ratingService.saveRating(productId, rating);
    state = {...state, productId: rating};
  }

  int getRating(String productId) {
    return state[productId] ?? 0;
  }
}

final currentRatingProvider =
    StateNotifierProvider<RatingNotifier, Map<String, int>>(
      (ref) => RatingNotifier(),
    );

// final currentRatingProviders = StateProvider<int>((ref) => 0);

// final quantityProvider = StateProvider<int>((ref) => 1); // handling quantity

final productDetailsVisibleProvider = StateProvider<bool>((ref) => false);
// handling product details visibility
final nutritionDetailsVisibleProvider = StateProvider<bool>((ref) => false);

final deleteItemProvider = StateProvider<bool>((ref) => false);
// handling delete item visibility

final productServiceProvider = Provider((ref) => ProductService());
final productListProvider = FutureProvider<List<Product>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/json/product.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((e) => Product.fromJson(e)).toList();
});

final selectedQuantityProvider = StateProvider<int>((ref) => 1);

final totalPriceProvider = Provider.family<double, double>((ref, productPrice) {
  final quantity = ref.watch(selectedQuantityProvider);
  return productPrice * quantity;
});

// final quantityProvider =
//     StateNotifierProvider<QuantityNotifier, Map<String, int>>(
//       (ref) => QuantityNotifier(),
//     );

// class QuantityNotifier extends StateNotifier<Map<String, int>> {
//   QuantityNotifier() : super({});

//   void increase(String productId) {
//     state = {...state, productId: (state[productId] ?? 1) + 1};
//   }

//   void decrease(String productId) {
//     final current = state[productId] ?? 1;
//     if (current > 1) {
//       state = {...state, productId: current - 1};
//     }
//   }

//   void setQuantity(String productId, int quantity) {
//     if (quantity < 1) return;
//     state = {...state, productId: quantity};
//   }

//   int getQuantity(String productId) => state[productId] ?? 1;
// }
