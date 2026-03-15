import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/data/date_dammy.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../../services/shared_prefs_service.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];
  final List<Product> _cart = [];
  final SharedPrefsService _prefsService = SharedPrefsService();

  ProductProvider() {
    _products.addAll(DummyData.products);
    _loadCart();
  }

  Future<void> _loadCart() async {
    final savedCart = await _prefsService.loadCart();
    _cart.addAll(savedCart);
    notifyListeners();
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

  /// Add [product] to the cart. If the product already exists, increment its quantity.
  void addToCart(Product product, {int qty = 1}) {
    final index = _cart.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _cart[index].quantity += qty;
    } else {
      product.quantity = qty;
      _cart.add(product);
    }
    _saveCart();
    notifyListeners();
  }

  /// Update the quantity of a product in the cart.
  void updateQuantity(Product product, int newQty) {
    final index = _cart.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (newQty <= 0) {
        _cart.removeAt(index);
      } else {
        _cart[index].quantity = newQty;
      }
      _saveCart();
      notifyListeners();
    }
  }

  /// Remove a [product] from the cart completely.
  void removeFromCart(Product product) {
    _cart.removeWhere((p) => p.id == product.id);
    _saveCart();
    notifyListeners();
  }

  /// Remove all wishlist flags (convenience helper).
  void clearWishlist() {
    for (var p in _products) {
      p.isFavorite = false;
    }
    notifyListeners();
  }

  /// Clear everything in the shopping cart.
  ///
  /// This is a convenience helper used when an order is placed so the cart
  /// becomes empty again. It will call [notifyListeners] so any consumers can
  /// rebuild with the updated state.
  void clearCart() {
    _cart.clear();
    _saveCart();
    notifyListeners();
  }

  /// Convenience helper to re‑order a previous order. The current cart is
  /// cleared and all items from [order] are added back in. Does not modify
  /// the order list itself (that responsibility lives elsewhere).
  void reorder(OrderModel order) {
    _cart.clear();
    _cart.addAll(order.products);
    _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    await _prefsService.saveCart(_cart);
  }
}
