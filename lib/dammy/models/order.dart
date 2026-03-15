import 'product.dart';

enum OrderStatus { shipped, delivered, cancelled, processing }

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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.processing,
      ),
      products: (json['products'] as List<dynamic>)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status.name,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }

  double get total => products.fold(0, (sum, item) => sum + item.price);
}
