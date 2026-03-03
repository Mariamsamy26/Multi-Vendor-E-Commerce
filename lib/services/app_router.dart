import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/app/auth_cycle/views/login_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/home_cycle/views/home_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/home_cycle/views/root_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/orders_cycle/views/orders_page.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/orders_cycle/views/order_details_screen.dart';
import 'package:multi_vendor_e_commerce/dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/product_cycle/views/product_details_page.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/profile_cycle/views/profile_page.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/profile_cycle/views/edit_profile_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/explore_cycle/views/categories_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/explore_cycle/views/category_products_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/explore_cycle/views/seller_products_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/explore_cycle/views/explore_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/wishlist_cycle/views/wishlist_page.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/cart_cycle/views/cart_screen.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/cart_cycle/views/checkout_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorExploreKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
final GlobalKey<NavigatorState> _shellNavigatorOrdersKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellOrders');
final GlobalKey<NavigatorState> _shellNavigatorCartKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellcart');
final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/product-details',
        builder: (context, state) => ProductDetailsScreen(
          product: state.extra as dynamic,
        ),
      ),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),

      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/category',
        builder: (context, state) => CategoryProductsScreen(
          categoryName: state.extra as String? ?? 'Category',
        ),
      ),
      GoRoute(
        path: '/seller',
        builder: (context, state) => SellerProductsScreen(
          sellerName: state.extra as String? ?? 'Seller',
        ),
      ),
      GoRoute(
        path: '/order-details',
        builder: (context, state) => OrderDetailsScreen(
          order: state.extra as OrderModel,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExploreKey,
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorOrdersKey,
            routes: [
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCartKey,
            routes: [
              GoRoute(
                path: '/cart',
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
