import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/date_dammy.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  final List<Product> _cart = [];

  ProductProvider() {
    _products.addAll(DummyData.products);
  }

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get wishlist =>
      _products.where((p) => p.isFavorite).toList(growable: false);

  List<Product> get cart => List.unmodifiable(_cart);

  /// Toggle favourite status for a product. Returns `true` if the product was
  /// **added to** the wishlist, `false` if it was removed. This makes the
  /// return value easier for UI code to interpret when showing snackbars.
  bool toggleWishlistStatus(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1) return false;

    final wasFav = _products[index].isFavorite;
    _products[index].isFavorite = !wasFav;
    notifyListeners();
    return !wasFav;
  }

  /// Add product to the wishlist; returns true if added (false if already
  /// present or unknown).
  bool addToWishlist(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1 || _products[index].isFavorite) return false;
    _products[index].isFavorite = true;
    notifyListeners();
    return true;
  }

  /// Remove product from the wishlist; returns true if removed.
  bool removeFromWishlist(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1 || !_products[index].isFavorite) return false;
    _products[index].isFavorite = false;
    notifyListeners();
    return true;
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
