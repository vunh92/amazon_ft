import 'package:amazon_ft/app/bloc/user/user_cubit.dart';
import 'package:amazon_ft/app/bloc/wish_list/wish_list_cubit.dart';
import 'package:amazon_ft/app/di.dart';
import 'package:amazon_ft/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:amazon_ft/presentation/views/auth/bloc/radio_bloc.dart';
import 'package:amazon_ft/presentation/views/bottom_navigation_bar/bloc/bottom_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/views/account/bloc/fetch_account_screen_data_cubit.dart';
import '../presentation/views/account/bloc/keep_shopping_for_cubit.dart';
import '../presentation/views/account/bloc/product_rating_bloc.dart';
import '../presentation/views/admin/bloc/add_product_images/admin_add_products_images_bloc.dart';
import '../presentation/views/admin/bloc/admin_bottom_bar_cubit/admin_bottom_bar_cubit.dart';
import '../presentation/views/admin/bloc/admin_fetch_category_products/admin_fetch_category_products_bloc.dart';
import '../presentation/views/admin/bloc/admin_fetch_orders_cubit/admin_fetch_orders_cubit.dart';
import '../presentation/views/admin/bloc/admin_get_analytics/admin_get_analytics_cubit.dart';
import '../presentation/views/admin/bloc/select_category_cubit/admin_add_select_category_cubit.dart';
import '../presentation/views/admin/bloc/sell_product_cubit/admin_sell_product_cubit.dart';
import '../presentation/views/cart/bloc/cart_bloc.dart';
import '../presentation/views/cart/bloc/cart_offers_cubit2/cart_offers_cubit.dart';
import '../presentation/views/cart/bloc/cart_offers_cubit3/cart_offers_cubit.dart';
import '../presentation/views/cart/bloc/cart_offers_cubit_1/cart_offers_cubit.dart';
import '../presentation/views/category_products/bloc/fetch_category_products_bloc.dart';
import '../presentation/views/home/bloc/admin_four_image_offer_cubit.dart';
import '../presentation/views/home/bloc/carousel_image_bloc.dart';
import '../presentation/views/home/bloc/deal_of_the_day_cubit.dart';
import '../presentation/views/payment/bloc/order_cubit.dart';
import '../presentation/views/payment/bloc/place_order_buy_now_cubit.dart';
import '../presentation/views/product_details/bloc/average_rating_cubit.dart';
import '../presentation/views/product_details/bloc/user_rating_cubit.dart';
import '../presentation/views/splash_screen/cubit/page_redirection_cubit.dart';
import 'config/config.dart';
import 'config/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PageRedirectionCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RadioBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<WishListCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<FetchAccountScreenDataCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<BottomBarBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CarouselImageBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminFourImageOfferCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DealOfTheDayCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<FetchCategoryProductsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserRatingCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AverageRatingCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<KeepShoppingForCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OrderCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PlaceOrderBuyNowCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductRatingBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartOffersCubit1>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartOffersCubit2>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartOffersCubit3>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminBottomBarCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminFetchOrdersCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminGetAnalyticsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminAddProductsImagesBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminAddSelectCategoryCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminSellProductCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AdminFetchCategoryProductsBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
