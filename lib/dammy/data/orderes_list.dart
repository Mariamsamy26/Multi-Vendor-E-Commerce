import 'package:multi_vendor_e_commerce/dammy/data/date_dammy.dart';

import '../models/order.dart';

class DummyOrders {
  DummyOrders._();

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'ORD-1001',
      date: DateTime(2025, 2, 10),
      status: OrderStatus.delivered,
      products: [
        DummyData.products[6],
      ],
    ),
    OrderModel(
      id: 'ORD-1002',
      date: DateTime(2025, 2, 15),
      status: OrderStatus.shipped,
      products: [
        DummyData.products[0],
        DummyData.products[1],
      ],
    ),
    OrderModel(
      id: 'ORD-1003',
      date: DateTime(2025, 2, 20),
      status: OrderStatus.delivered,
      products: [
        DummyData.products[9],
      ],
    ),
  ];

  static getDummyOrders() {}
}