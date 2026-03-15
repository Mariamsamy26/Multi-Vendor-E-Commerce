import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../dammy/models/product.dart';
import '../dammy/models/order.dart';
import '../dammy/models/profile_model.dart';

class SharedPrefsService {
  static const String _cartKey = 'cart_items';
  static const String _ordersKey = 'order_history';
  static const String _profileKey = 'user_profile';

  // --- Cart ---
  Future<void> saveCart(List<Product> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = cart.map((p) => p.toJson()).toList();
    await prefs.setString(_cartKey, jsonEncode(jsonList));
  }

  Future<List<Product>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  // --- Orders ---
  Future<void> saveOrders(List<OrderModel> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = orders.map((o) => o.toJson()).toList();
    await prefs.setString(_ordersKey, jsonEncode(jsonList));
  }

  Future<List<OrderModel>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_ordersKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  // --- Profile ---
  Future<void> saveProfile(ProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  Future<ProfileModel?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_profileKey);
    if (jsonString != null) {
      return ProfileModel.fromJson(jsonDecode(jsonString));
    }
    return null; // Return null if not found
  }
}
