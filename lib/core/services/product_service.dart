import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';

class ProductService {
  Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString('assets/json/product.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((json) => Product.fromJson(json)).toList();
  }
}
