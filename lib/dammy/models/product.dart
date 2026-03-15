class Product {
  final String id;
  final String name;
  final String category;
  final String vendor;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  bool inStock;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.vendor,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.inStock = true,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      vendor: json['vendor'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      inStock: json['inStock'] as bool? ?? true,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'vendor': vendor,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'inStock': inStock,
      'isFavorite': isFavorite,
    };
  }
}
