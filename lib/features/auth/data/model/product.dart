class Product {
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  final String category;
  final int selectedQuantity;
  final double totalPrice;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.category,
    required this.selectedQuantity,
    required this.totalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      productPrice: (json['productPrice'] as num?)?.toDouble() ?? 0.0,
      productQuantity: (json['productQuantity'] ?? 0) as int,
      category: json['category'] ?? '',
      selectedQuantity: (json['selectedQuantity'] ?? 0) as int,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productName': productName,
    'productImage': productImage,
    'productPrice': productPrice,
    'productQuantity': productQuantity,
    'selectedQuantity': selectedQuantity,
    'totalPrice': totalPrice,
  };
}
