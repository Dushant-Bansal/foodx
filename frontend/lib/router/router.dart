import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:food_x/screens/product/bloc/product_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/product/view/add_product.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:food_x/screens/product/view/view_product.dart';
import 'package:food_x/screens/shop/bloc/shop_bloc.dart';
import 'package:food_x/screens/shop/view/shop.dart';
import 'package:food_x/screens/spaces/models/space.dart';
import 'package:food_x/screens/spaces/view/spaces.dart';
import 'package:food_x/screens/spaces/view/widgets/space_settings.dart';
import 'package:go_router/go_router.dart';
import '../screens/home/view/home.dart';
import '../screens/auth/view/initial_page.dart';
import '../screens/inventory/bloc/inventory_bloc.dart';
import '../services/auth_service.dart';
import '../screens/bottom_bar/bottom_bar.dart';
import '../screens/inventory/view/inventory.dart';
import '../../screens/to_be_implemented/to_be_implemented.dart';
import '../router/constants.dart';

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: initialPage,
  routes: [
    // Initial Page (Sign Up)
    GoRoute(
      path: initialPage,
      builder: (context, state) => const InitialPage(),
      redirect: (context, state) {
        FlutterNativeSplash.remove();
        return AuthService.isUserSignedIn ? home : null;
      },
    ),

    // Shell Route for Bottom Bar
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return BlocProvider(
            create: (context) => BottomBarCubit(),
            child: BottomBar(child: child));
      },
      routes: <GoRoute>[
        // HomePage
        GoRoute(
          path: home,
          builder: (context, state) => const Home(),
          routes: <GoRoute>[
            // Add Product
            GoRoute(
                path: addProduct,
                parentNavigatorKey: navigatorKey,
                builder: (context, state) => BlocProvider(
                    create: (context) => ProductBloc(),
                    child: AddProduct(mode: state.extra as Mode))),

            // Inventory
            GoRoute(
              path: inventory,
              builder: (context, state) => const Inventory(),
              routes: <GoRoute>[
                // View Product
                GoRoute(
                  path: viewProduct,
                  builder: (context, state) => ViewProduct(
                    product: state.extra as Product,
                    onProductDelete: (id) {
                      context
                          .read<InventoryBloc>()
                          .add(InventoryProductRemove(id));
                      context.pop();
                    },
                    onShoppingBagPressed: (product) {
                      context.read<InventoryBloc>().add(InventoryProductUpdate(
                          product.copyWith(isShop: !product.isShop)));
                    },
                  ),
                ),
              ],
            ),

            // Spaces
            GoRoute(
              path: spaces,
              builder: (context, state) => const Spaces(),
              routes: <GoRoute>[
                // Space Settings
                GoRoute(
                    path: spaceSettings,
                    builder: (context, state) =>
                        SpaceSettings(space: state.extra as Space)),

                // Space Inventory
                GoRoute(
                  path: inventory,
                  builder: (context, state) {
                    final qParams = state.uri.queryParameters;
                    final isSpace = bool.tryParse(qParams['isSpace'] ?? '');
                    final spaceId = qParams['spaceId'];
                    return Inventory(isSpace: isSpace, spaceId: spaceId);
                  },
                  routes: <GoRoute>[
                    // View Product
                    GoRoute(
                      path: viewProduct,
                      builder: (context, state) {
                        return ViewProduct(
                          product: state.extra as Product,
                          onProductDelete: null,
                          onShoppingBagPressed: (product) {
                            context.read<InventoryBloc>().add(
                                InventoryProductUpdate(
                                    product.copyWith(isShop: !product.isShop)));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Shop
            GoRoute(
                path: shop,
                builder: (context, state) => BlocProvider(
                    create: (context) => ShopBloc(), child: const Shop())),

            // To_Be_Implemented
            GoRoute(
                path: toBeImplemented,
                parentNavigatorKey: navigatorKey,
                builder: (context, state) => const ToBeImplemented()),
          ],
        ),
      ],
    ),
  ],
);

extension ContextX on BuildContext {
  String? get path => GoRouterState.of(this).fullPath;
}
