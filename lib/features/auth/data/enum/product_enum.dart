import 'package:flutter/material.dart';

enum ProductEnum {
  freshfruitvegetable,
  cookingoilghee,
  meatfish,
  bakerysnack,
  dairyegg,
  beverages,
}

extension ProductEnumExtension on ProductEnum {
  String get name {
    switch (this) {
      case ProductEnum.freshfruitvegetable:
        return 'Fresh Fruit & Vegetables';
      case ProductEnum.cookingoilghee:
        return 'Cooking Oil & Ghee';
      case ProductEnum.meatfish:
        return 'Meat & Fish';
      case ProductEnum.bakerysnack:
        return 'Bakery & Snacks';
      case ProductEnum.dairyegg:
        return 'Dairy & Eggs';
      case ProductEnum.beverages:
        return 'Beverages';
    }
  }

  ProductEnum? getCategoryEnum(String category) {
    switch (category) {
      case 'Fresh Fruit & Vegetables':
        return ProductEnum.freshfruitvegetable;
      case 'Cooking Oil & Ghee':
        return ProductEnum.cookingoilghee;
      case 'Meat & Fish':
        return ProductEnum.meatfish;
      case 'Bakery & Snacks':
        return ProductEnum.bakerysnack;
      case 'Dairy & Eggs':
        return ProductEnum.dairyegg;
      case 'Beverages':
        return ProductEnum.beverages;
      default:
        return null;
    }
  }

  Color get color {
    switch (this) {
      case ProductEnum.freshfruitvegetable:
        return Color(0xFF53B175);
      case ProductEnum.cookingoilghee:
        return Color(0xFFF8A44C);
      case ProductEnum.meatfish:
        return Color(0xFFF7A593);
      case ProductEnum.bakerysnack:
        return Color(0xFFD3B0E0);
      case ProductEnum.dairyegg:
        return Color(0xFFFDE598);
      case ProductEnum.beverages:
        return Color(0xFFB7DFF5);
    }
  }

  String get pngAssetPath {
    switch (this) {
      case ProductEnum.freshfruitvegetable:
        return 'assets/images/product/fruit_vegetable.png';
      case ProductEnum.cookingoilghee:
        return 'assets/images/product/cookingoil_ghee.png';
      case ProductEnum.meatfish:
        return 'assets/images/product/meat_fish.png';
      case ProductEnum.bakerysnack:
        return 'assets/images/product/bakery_snack.png';
      case ProductEnum.dairyegg:
        return 'assets/images/product/dairy_milk.png';
      case ProductEnum.beverages:
        return 'assets/images/product/beverages.png';
    }
  }
}
