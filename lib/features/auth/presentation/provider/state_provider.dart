import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';

final passwordVisibilityProvider = StateProvider<bool>(
  (ref) => false,
); // holding value of password visibility

final selectedIndexProvider = StateProvider<int>(
  (ref) => 0,
); // holding  value for navigation bar

final selectedFavoriteProvider = StateProvider<int>(
  (ref) => Color(0xFF7C7C7C).value,
); // handling favorite selection

final currentRatingProvider = StateProvider<int>((ref) => 0); // handling rating

final quantityProvider = StateProvider<int>((ref) => 1); // handling quantity

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
