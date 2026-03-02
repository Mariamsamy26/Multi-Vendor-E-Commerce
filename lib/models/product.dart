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
}
