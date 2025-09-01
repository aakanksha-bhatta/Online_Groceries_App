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

  String get svgAssetPath {
    switch (this) {
      case ProductEnum.freshfruitvegetable:
        return 'assets/images/fresh_fruit_vegetable.svg';
      case ProductEnum.cookingoilghee:
        return 'assets/images/cooking_oil_ghee.svg';
      case ProductEnum.meatfish:
        return 'assets/images/meat_fish.svg';
      case ProductEnum.bakerysnack:
        return 'assets/images/bakery_snack.svg';
      case ProductEnum.dairyegg:
        return 'assets/images/dairy_egg.svg';
      case ProductEnum.beverages:
        return 'assets/images/beverages.svg';
    }
  }
}
