import '../models/product.dart';

class DummyData {
  DummyData._();

  static final List<Product> products = [
    // ================= Electronics =================
    Product(
      id: 'p1',
      name: 'Wireless Headphones Pro',
      category: 'Electronics',
      vendor: 'TechStore',
      imageUrl: 'https://images.unsplash.com/photo-1518444065439-e933c06ce9cd',
      price: 89.0,
      originalPrice: 129.0,
    ),

    Product(
      id: 'p2',
      name: 'Smartphone X12',
      category: 'Electronics',
      vendor: 'MobileHub',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      price: 60.0,
    ),

    Product(
      id: 'p3',
      name: 'Smart Watch Fit',
      category: 'Electronics',
      vendor: 'TechStore',
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12',
      price: 149.0,
      originalPrice: 10.0,
    ),

    Product(
      id: 'p4',
      name: 'Ultrabook Laptop 14"',
      category: 'Electronics',
      vendor: 'LaptopWorld',
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      price: 100.00,
      inStock: false,
    ),

    // ================= Fashion =================
    Product(
      id: 'p5',
      name: 'Cotton T-Shirt Basic',
      category: 'Fashion',
      vendor: 'StyleWear',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
      price: 19.0,
      originalPrice: 29.0,
    ),

    Product(
      id: 'p6',
      name: 'Leather Handbag Classic',
      category: 'Fashion',
      vendor: 'UrbanBag',
      imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3',
      price: 79.0,
    ),

    Product(
      id: 'p7',
      name: 'Running Sneakers Air',
      category: 'Fashion',
      vendor: 'Sportify',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      price: 120.00,
      originalPrice: 150.00,
    ),

    Product(
      id: 'p8',
      name: 'Casual Hoodie',
      category: 'Fashion',
      vendor: 'StreetStyle',
      imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
      price: 49.0,
    ),

    // ================= Home & Kitchen =================
    Product(
      id: 'p9',
      name: 'Coffee Maker Deluxe',
      category: 'Home',
      vendor: 'HomePlus',
      imageUrl: 'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0',
      price: 59.0,
    ),

    Product(
      id: 'p10',
      name: 'Minimal Desk Lamp',
      category: 'Home',
      vendor: 'LightHouse',
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c',
      price: 34.0,
    ),

    Product(
      id: 'p11',
      name: 'Ergonomic Office Chair',
      category: 'Home',
      vendor: 'ComfortZone',
      imageUrl: 'https://images.unsplash.com/photo-1580480055273-228ff5388ef8',
      price: 249.0,
      originalPrice: 20.0,
    ),

    Product(
      id: 'p12',
      name: 'Kitchen Knife Set',
      category: 'Home',
      vendor: 'ChefPro',
      imageUrl: 'https://images.unsplash.com/photo-159361808160-e34014e67546',
      price: 69.0,
    ),
  ];
}
