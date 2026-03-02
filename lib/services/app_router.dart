import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/app/auth_cycle/views/login_page.dart';
import 'package:multi_vendor_e_commerce/app/explore_cycle/views/categories_page.dart';
import 'package:multi_vendor_e_commerce/app/explore_cycle/views/explore_page.dart';
import 'package:multi_vendor_e_commerce/app/home_cycle/views/pages/home_page.dart';
import 'package:multi_vendor_e_commerce/app/home_cycle/views/pages/main_scaffold.dart';
import 'package:multi_vendor_e_commerce/app/orders_cycle/views/orders_page.dart';
import 'package:multi_vendor_e_commerce/app/product_cycle/views/product_details_page.dart';
import 'package:multi_vendor_e_commerce/app/profile_cycle/views/profile_page.dart';
import 'package:multi_vendor_e_commerce/app/wishlist_cycle/views/wishlist_page.dart';
import 'package:multi_vendor_e_commerce/app/cart_cycle/views/cart_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorExploreKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
final GlobalKey<NavigatorState> _shellNavigatorOrdersKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellOrders');
final GlobalKey<NavigatorState> _shellNavigatorWishlistKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellWishlist');
final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/product-details',
        builder: (context, state) => ProductDetailsPage(
          product: state.extra as dynamic,
        ),
      ),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistPage(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExploreKey,
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorOrdersKey,
            routes: [
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrdersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorWishlistKey,
            routes: [
              GoRoute(
                path: '/cart',
                builder: (context, state) => const CartPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
