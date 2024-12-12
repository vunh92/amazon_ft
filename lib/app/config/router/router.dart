import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/order.dart';
import '../../../domain/model/product.dart';
import '../../../domain/repository/account_repository.dart';
import '../../../presentation/views/account/bloc/fetch_orders_cubit.dart';
import '../../../presentation/views/account/bloc/keep_shopping_for_cubit.dart';
import '../../../presentation/views/account/bloc/product_rating_bloc.dart';
import '../../../presentation/views/account/browsing_history.dart';
import '../../../presentation/views/account/order_details.dart';
import '../../../presentation/views/account/search_orders_screen.dart';
import '../../../presentation/views/account/wish_list_screen.dart';
import '../../../presentation/views/account/your_orders.dart';
import '../../../presentation/views/admin/admin_add_offer_screen.dart';
import '../../../presentation/views/admin/admin_add_product_screen.dart';
import '../../../presentation/views/admin/admin_bottom_bar.dart';
import '../../../presentation/views/admin/admin_category_products_screen.dart';
import '../../../presentation/views/another/another_screen.dart';
import '../../../presentation/views/auth/auth_screen.dart';
import '../../../presentation/views/bottom_navigation_bar/bottom_bar.dart';
import '../../../presentation/views/cart/cart_screen.dart';
import '../../../presentation/views/category_products/bloc/fetch_category_products_bloc.dart';
import '../../../presentation/views/category_products/category_products_screen.dart';
import '../../../presentation/views/home/home_screen.dart';
import '../../../presentation/views/menu/menu_screen.dart';
import '../../../presentation/views/payment/payment_screen.dart';
import '../../../presentation/views/payment/payment_screen_buy_now.dart';
import '../../../presentation/views/product_details/product_details_screen.dart';
import '../../../presentation/views/splash_screen/splash_screen.dart';
import '../../bloc/wish_list/wish_list_cubit.dart';
import '../../di.dart';
import 'app_route_constants.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: AppRouteConstants.splashScreen.name,
    path: AppRouteConstants.splashScreen.path,
    pageBuilder: (context, state) {
      return const MaterialPage(child: SplashScreen());
    },
  ),
  GoRoute(
    name: AppRouteConstants.authRoute.name,
    path: AppRouteConstants.authRoute.path,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const AuthScreen(),
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.ease).animate(animation),
            child: child,
          );
        },
      );
      return const MaterialPage(child: AuthScreen());
    },
  ),
  GoRoute(
    name: AppRouteConstants.bottomBarRoute.name,
    path: AppRouteConstants.bottomBarRoute.path,
    pageBuilder: (context, state) {
      return MaterialPage(child: BottomBar());
    },
  ),
  GoRoute(
    name: AppRouteConstants.homeScreenRoute.name,
    path: AppRouteConstants.homeScreenRoute.path,
    pageBuilder: (context, state) {
      return const MaterialPage(child: HomeScreen());
    },
  ),
  GoRoute(
    name: AppRouteConstants.anotherScreenRoute.name,
    path: AppRouteConstants.anotherScreenRoute.path,
    pageBuilder: (context, state) {
      final String appBarTitle = state.pathParameters['appBarTitle']!;
      return MaterialPage(
          child: AnotherScreen(
            appBarTitle: appBarTitle,
          ));
    },
  ),
  GoRoute(
      name: AppRouteConstants.cartScreenScreenRoute.name,
      path: AppRouteConstants.cartScreenScreenRoute.path,
      pageBuilder: (context, state) {
        return const MaterialPage(child: CartScreen());
      }),
  GoRoute(
      name: AppRouteConstants.menuScreenRoute.name,
      path: AppRouteConstants.menuScreenRoute.path,
      pageBuilder: (context, state) {
        return const MaterialPage(child: MenuScreen());
      }),
  GoRoute(
    name: AppRouteConstants.categoryproductsScreenRoute.name,
    path: '${AppRouteConstants.categoryproductsScreenRoute.path}/:category',
    pageBuilder: (context, state) {
      final category = state.pathParameters['category'];

      return MaterialPage(
          child: BlocProvider.value(
            value: getIt<FetchCategoryProductsBloc>()
              ..add(CategoryPressedEvent(category: category!)),
            child: CategoryProductsScreen(category: category),
          ));
    },
  ),
  GoRoute(
    name: AppRouteConstants.productDetailsScreenRoute.name,
    path: AppRouteConstants.productDetailsScreenRoute.path,
    pageBuilder: (context, state) {
      Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;

      final product = extraData["product"] as Product;
      final deliveryDate = extraData["deliveryDate"] as String;
      return MaterialPage(
          child: BlocProvider.value(
            value: getIt<FetchCategoryProductsBloc>()..add(CategoryPressedEvent(category: product.category)),
            child: ProductDetailsScreen(
              product: product,
              deliveryDate: deliveryDate,
            ),
          ));
    },
  ),
  GoRoute(
      name: AppRouteConstants.buyNowPaymentScreenRoute.name,
      path: AppRouteConstants.buyNowPaymentScreenRoute.path,
      pageBuilder: (context, state) {
        Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;

        Product product = extraData['product'] as Product;
        return MaterialPage(
            child: PaymentScreenBuyNow(
              product: product,
            ));
      }),
  GoRoute(
      path: AppRouteConstants.yourOrdersScreenRoute.path,
      name: AppRouteConstants.yourOrdersScreenRoute.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider.value(
            value: getIt<FetchOrdersCubit>()..fetchOrders(),
            child: const YourOrders(),
          ),
        );
      }),
  GoRoute(
      path: AppRouteConstants.yourWishListScreenRoute.path,
      name: AppRouteConstants.yourWishListScreenRoute.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider.value(
            value: getIt<WishListCubit>()
              ..getWishList(),
            child: const WishListScreen(),
          ),
        );
      }),
  GoRoute(
    name: AppRouteConstants.browsingHistoryScreenRoute.name,
    path: AppRouteConstants.browsingHistoryScreenRoute.path,
    pageBuilder: (context, state) {
      return MaterialPage(
          child: BlocProvider.value(
              value: getIt<KeepShoppingForCubit>()..keepShoppingFor(),
              child: const BrowsingHistory()));
    },
  ),
  GoRoute(
    name: AppRouteConstants.searchOrdersScreenRoute.name,
    path: '${AppRouteConstants.searchOrdersScreenRoute.path}/:orderQuery',
    pageBuilder: (context, state) {
      final orderQuery = state.pathParameters['orderQuery'];
      return MaterialPage(
          child: BlocProvider.value(
            value: getIt<FetchOrdersCubit>()..fetchSearchedOrders(orderQuery!),
            child: SearchOrderScreen(orderQuery: orderQuery),
          ));
    },
  ),
  GoRoute(
    name: AppRouteConstants.orderDetailsScreenRoute.name,
    path: AppRouteConstants.orderDetailsScreenRoute.path,
    pageBuilder: (context, state) {
      final order = state.extra as Order;

      return MaterialPage(
          child: BlocProvider.value(
            value: getIt<ProductRatingBloc>()
              ..add(GetProductRatingEvent(order: order)),
            child: OrderDetailsScreen(order: order),
          ));
    },
  ),
  GoRoute(
      name: AppRouteConstants.paymentScreenRoute.name,
      path: AppRouteConstants.paymentScreenRoute.path,
      pageBuilder: (context, state) {
        double totalAmount = state.extra as double;
        return MaterialPage(
            child: PaymentScreen(totalAmount: totalAmount.toString()));
      }),

  // admin
  GoRoute(
    path: AppRouteConstants.adminBottomBarRoute.path,
    name: AppRouteConstants.adminBottomBarRoute.name,
    pageBuilder: (context, state) {
      return const MaterialPage(child: AdminBottomBar());
    },
  ),
  GoRoute(
    path: AppRouteConstants.adminAddProductsScreen.path,
    name: AppRouteConstants.adminAddProductsScreen.name,
    pageBuilder: (context, state) {
      return const MaterialPage(child: AdminAddProductScreen());
    },
  ),
  GoRoute(
    path: AppRouteConstants.adminAddOfferScreen.path,
    name: AppRouteConstants.adminAddOfferScreen.name,
    pageBuilder: (context, state) {
      return const MaterialPage(child: AdminAddOfferScreen());
    },
  ),
  GoRoute(
    path: AppRouteConstants.adminCategoryProductsScreen.path,
    name: AppRouteConstants.adminCategoryProductsScreen.name,
    pageBuilder: (context, state) {
      String category = state.extra as String;

      return MaterialPage(
          child: AdminCategoryProductsScreen(
            category: category,
          ));
    },
  ),
]);
