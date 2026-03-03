import 'product.dart';

enum OrderStatus { shipped, delivered }

class OrderModel {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final List<Product> products;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.products,
  });

  double get total =>
      products.fold(0, (sum, item) => sum + item.price);
}