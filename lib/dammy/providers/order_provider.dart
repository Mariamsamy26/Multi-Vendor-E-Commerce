import 'package:flutter/material.dart';
import '../models/order.dart';
import '../../services/shared_prefs_service.dart';
import '../data/orderes_list.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  final SharedPrefsService _prefsService = SharedPrefsService();
  bool _isLoading = true;

  OrderProvider() {
    _loadOrders();
  }

  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;

  Future<void> _loadOrders() async {
    final savedOrders = await _prefsService.loadOrders();
    if (savedOrders.isNotEmpty) {
      _orders.addAll(savedOrders);
    } else {
      // Fallback to dummy data if no local data exists yet
      _orders.addAll(DummyOrders.orders);
    }
    _isLoading = false;
    notifyListeners();
  }

  void placeOrder(OrderModel order) {
    _orders.insert(0, order);
    _saveOrders();
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final oldOrder = _orders[index];
      _orders[index] = OrderModel(
        id: oldOrder.id,
        date: oldOrder.date,
        status: newStatus,
        products: oldOrder.products,
      );
      _saveOrders();
      notifyListeners();
    }
  }

  Future<void> _saveOrders() async {
    await _prefsService.saveOrders(_orders);
  }
}
