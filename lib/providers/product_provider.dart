import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  /// All available products in the store.
  final List<Product> _products = [];

  /// Items currently in the user's cart. We allow duplicates to represent
  /// quantity; the caller is responsible for managing counts if desired.
  final List<Product> _cart = [];

  ProductProvider() {
    // Initialize with some sample data so the UI can build immediately.
    final placeholder =
        'https://via.placeholder.com/300.png?text=Product+'; // base placeholder

    _products.addAll(
      List.generate(
        10,
        (index) => Product(
          id: 'p\$index',
          name: 'Product #\$index',
          category: 'Category \\${index % 3}',
          vendor: 'Vendor \\${index % 2}',
          imageUrl: '$placeholder$index',
          price: 19.99 + index,
          originalPrice: 29.99 + index,
          inStock: index % 4 != 0,
        ),
      ),
    );
  }

  /// Unmodifiable view of all products.
  List<Product> get products => List.unmodifiable(_products);

  /// Computed wishlist derived from products marked favorite.
  List<Product> get wishlist =>
      _products.where((p) => p.isFavorite).toList(growable: false);

  /// The items that have been added to cart. A simple list for now.
  List<Product> get cart => List.unmodifiable(_cart);

  /// Toggle favorite status for a product. Returns the new status (`true` if
  /// now favorited). If the product is not part of the catalogue the call is
  /// ignored and `false` is returned.
  bool toggleWishlistStatus(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1) return false;
    _products[index].isFavorite = !_products[index].isFavorite;
    final newStatus = _products[index].isFavorite;
    notifyListeners();
    return newStatus;
  }

  /// Add [product] to the cart. Duplicates are allowed.
  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  /// Remove a single instance of [product] from the cart if it exists.
  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  /// Remove all wishlist flags (convenience helper).
  void clearWishlist() {
    for (var p in _products) {
      p.isFavorite = false;
    }
    notifyListeners();
  }
}
