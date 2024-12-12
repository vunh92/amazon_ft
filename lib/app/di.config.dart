// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:amazon_ft/app/bloc/user/user_cubit.dart' as _i916;
import 'package:amazon_ft/app/bloc/wish_list/wish_list_cubit.dart' as _i873;
import 'package:amazon_ft/data/data_source/api/account_api.dart' as _i392;
import 'package:amazon_ft/data/data_source/api/admin_api.dart' as _i154;
import 'package:amazon_ft/data/data_source/api/auth_api.dart' as _i512;
import 'package:amazon_ft/data/data_source/api/category_products_api.dart'
    as _i254;
import 'package:amazon_ft/data/data_source/api/products_api.dart' as _i111;
import 'package:amazon_ft/data/data_source/api/user_api.dart' as _i1022;
import 'package:amazon_ft/data/repository/account_repository_impl.dart'
    as _i898;
import 'package:amazon_ft/data/repository/admin_repository_impl.dart' as _i605;
import 'package:amazon_ft/data/repository/auth_repository_impl.dart' as _i635;
import 'package:amazon_ft/data/repository/category_products_repository_impl.dart'
    as _i513;
import 'package:amazon_ft/data/repository/products_repository_impl.dart'
    as _i334;
import 'package:amazon_ft/data/repository/user_repository_impl.dart' as _i239;
import 'package:amazon_ft/domain/repository/account_repository.dart' as _i692;
import 'package:amazon_ft/domain/repository/admin_repository.dart' as _i556;
import 'package:amazon_ft/domain/repository/auth_repository.dart' as _i685;
import 'package:amazon_ft/domain/repository/category_products_repository.dart'
    as _i1045;
import 'package:amazon_ft/domain/repository/products_repository.dart' as _i986;
import 'package:amazon_ft/domain/repository/user_repository.dart' as _i935;
import 'package:amazon_ft/domain/usecase/account_usecase.dart' as _i216;
import 'package:amazon_ft/domain/usecase/admin_usecase.dart' as _i42;
import 'package:amazon_ft/domain/usecase/auth_usecase.dart' as _i7;
import 'package:amazon_ft/domain/usecase/redirection_usecase.dart' as _i236;
import 'package:amazon_ft/domain/usecase/user_usecase.dart' as _i933;
import 'package:amazon_ft/presentation/views/account/bloc/fetch_account_screen_data_cubit.dart'
    as _i1043;
import 'package:amazon_ft/presentation/views/account/bloc/fetch_orders_cubit.dart'
    as _i351;
import 'package:amazon_ft/presentation/views/account/bloc/keep_shopping_for_cubit.dart'
    as _i406;
import 'package:amazon_ft/presentation/views/account/bloc/product_rating_bloc.dart'
    as _i1001;
import 'package:amazon_ft/presentation/views/admin/bloc/add_product_images/admin_add_products_images_bloc.dart'
    as _i1019;
import 'package:amazon_ft/presentation/views/admin/bloc/admin_bottom_bar_cubit/admin_bottom_bar_cubit.dart'
    as _i138;
import 'package:amazon_ft/presentation/views/admin/bloc/admin_fetch_category_products/admin_fetch_category_products_bloc.dart'
    as _i616;
import 'package:amazon_ft/presentation/views/admin/bloc/admin_fetch_orders_cubit/admin_fetch_orders_cubit.dart'
    as _i385;
import 'package:amazon_ft/presentation/views/admin/bloc/admin_get_analytics/admin_get_analytics_cubit.dart'
    as _i163;
import 'package:amazon_ft/presentation/views/admin/bloc/select_category_cubit/admin_add_select_category_cubit.dart'
    as _i1045;
import 'package:amazon_ft/presentation/views/admin/bloc/sell_product_cubit/admin_sell_product_cubit.dart'
    as _i891;
import 'package:amazon_ft/presentation/views/auth/bloc/auth_bloc.dart' as _i231;
import 'package:amazon_ft/presentation/views/auth/bloc/radio_bloc.dart'
    as _i1059;
import 'package:amazon_ft/presentation/views/bottom_navigation_bar/bloc/bottom_bar_bloc.dart'
    as _i964;
import 'package:amazon_ft/presentation/views/cart/bloc/cart_bloc.dart' as _i344;
import 'package:amazon_ft/presentation/views/cart/bloc/cart_offers_cubit2/cart_offers_cubit.dart'
    as _i809;
import 'package:amazon_ft/presentation/views/cart/bloc/cart_offers_cubit3/cart_offers_cubit.dart'
    as _i140;
import 'package:amazon_ft/presentation/views/cart/bloc/cart_offers_cubit_1/cart_offers_cubit.dart'
    as _i385;
import 'package:amazon_ft/presentation/views/category_products/bloc/fetch_category_products_bloc.dart'
    as _i786;
import 'package:amazon_ft/presentation/views/home/bloc/admin_four_image_offer_cubit.dart'
    as _i1059;
import 'package:amazon_ft/presentation/views/home/bloc/carousel_image_bloc.dart'
    as _i1026;
import 'package:amazon_ft/presentation/views/home/bloc/deal_of_the_day_cubit.dart'
    as _i614;
import 'package:amazon_ft/presentation/views/payment/bloc/order_cubit.dart'
    as _i311;
import 'package:amazon_ft/presentation/views/payment/bloc/place_order_buy_now_cubit.dart'
    as _i437;
import 'package:amazon_ft/presentation/views/product_details/bloc/average_rating_cubit.dart'
    as _i316;
import 'package:amazon_ft/presentation/views/product_details/bloc/user_rating_cubit.dart'
    as _i143;
import 'package:amazon_ft/presentation/views/splash_screen/cubit/page_redirection_cubit.dart'
    as _i358;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i154.AdminApi>(() => _i154.AdminApi());
    gh.factory<_i254.CategoryProductsApi>(() => _i254.CategoryProductsApi());
    gh.factory<_i111.ProductsApi>(() => _i111.ProductsApi());
    gh.factory<_i138.AdminBottomBarCubit>(() => _i138.AdminBottomBarCubit());
    gh.factory<_i1045.AdminAddSelectCategoryCubit>(
        () => _i1045.AdminAddSelectCategoryCubit());
    gh.factory<_i1059.RadioBloc>(() => _i1059.RadioBloc());
    gh.factory<_i964.BottomBarBloc>(() => _i964.BottomBarBloc());
    gh.factory<_i1026.CarouselImageBloc>(() => _i1026.CarouselImageBloc());
    gh.lazySingleton<_i392.AccountApi>(() => _i392.AccountApi());
    gh.lazySingleton<_i512.AuthAPI>(() => _i512.AuthAPI());
    gh.lazySingleton<_i1022.UserApi>(() => _i1022.UserApi());
    gh.factory<_i692.AccountRepository>(
        () => _i898.AccountRepositoryImpl(gh<_i392.AccountApi>()));
    gh.factory<_i1045.CategoryProductsRepository>(() =>
        _i513.CategoryProductsRepositoryImpl(gh<_i254.CategoryProductsApi>()));
    gh.factory<_i986.ProductsRepository>(
        () => _i334.ProductsRepositoryImpl(gh<_i111.ProductsApi>()));
    gh.factory<_i809.CartOffersCubit2>(() => _i809.CartOffersCubit2(
          gh<_i692.AccountRepository>(),
          gh<_i1045.CategoryProductsRepository>(),
        ));
    gh.factory<_i140.CartOffersCubit3>(() => _i140.CartOffersCubit3(
          gh<_i692.AccountRepository>(),
          gh<_i1045.CategoryProductsRepository>(),
        ));
    gh.factory<_i385.CartOffersCubit1>(() => _i385.CartOffersCubit1(
          gh<_i692.AccountRepository>(),
          gh<_i1045.CategoryProductsRepository>(),
        ));
    gh.factory<_i614.DealOfTheDayCubit>(
        () => _i614.DealOfTheDayCubit(gh<_i986.ProductsRepository>()));
    gh.factory<_i556.AdminRepository>(
        () => _i605.AdminRepositoryImpl(gh<_i154.AdminApi>()));
    gh.factory<_i935.UserRepository>(
        () => _i239.UserRepositoryImpl(gh<_i1022.UserApi>()));
    gh.factory<_i685.AuthRepository>(
        () => _i635.AuthRepositoryImpl(gh<_i512.AuthAPI>()));
    gh.factory<_i316.AverageRatingCubit>(() => _i316.AverageRatingCubit(
          gh<_i692.AccountRepository>(),
          gh<_i986.ProductsRepository>(),
        ));
    gh.lazySingleton<_i786.FetchCategoryProductsBloc>(
        () => _i786.FetchCategoryProductsBloc(
              gh<_i1045.CategoryProductsRepository>(),
              gh<_i692.AccountRepository>(),
            ));
    gh.factory<_i216.AccountUseCase>(
        () => _i216.AccountUseCase(gh<_i692.AccountRepository>()));
    gh.factory<_i351.FetchOrdersCubit>(
        () => _i351.FetchOrdersCubit(gh<_i692.AccountRepository>()));
    gh.factory<_i406.KeepShoppingForCubit>(
        () => _i406.KeepShoppingForCubit(gh<_i692.AccountRepository>()));
    gh.factory<_i1001.ProductRatingBloc>(
        () => _i1001.ProductRatingBloc(gh<_i692.AccountRepository>()));
    gh.factory<_i143.UserRatingCubit>(
        () => _i143.UserRatingCubit(gh<_i692.AccountRepository>()));
    gh.factory<_i7.AuthUseCase>(
        () => _i7.AuthUseCase(gh<_i685.AuthRepository>()));
    gh.factory<_i916.UserCubit>(
        () => _i916.UserCubit(gh<_i935.UserRepository>()));
    gh.factory<_i236.RedirectionUseCase>(
        () => _i236.RedirectionUseCase(gh<_i935.UserRepository>()));
    gh.factory<_i311.OrderCubit>(
        () => _i311.OrderCubit(gh<_i935.UserRepository>()));
    gh.factory<_i437.PlaceOrderBuyNowCubit>(
        () => _i437.PlaceOrderBuyNowCubit(gh<_i935.UserRepository>()));
    gh.factory<_i42.AdminUseCase>(
        () => _i42.AdminUseCase(gh<_i556.AdminRepository>()));
    gh.factory<_i1019.AdminAddProductsImagesBloc>(
        () => _i1019.AdminAddProductsImagesBloc(gh<_i556.AdminRepository>()));
    gh.factory<_i385.AdminFetchOrdersCubit>(
        () => _i385.AdminFetchOrdersCubit(gh<_i556.AdminRepository>()));
    gh.factory<_i163.AdminGetAnalyticsCubit>(
        () => _i163.AdminGetAnalyticsCubit(gh<_i556.AdminRepository>()));
    gh.factory<_i891.AdminSellProductCubit>(
        () => _i891.AdminSellProductCubit(gh<_i556.AdminRepository>()));
    gh.factory<_i616.AdminFetchCategoryProductsBloc>(() =>
        _i616.AdminFetchCategoryProductsBloc(gh<_i556.AdminRepository>()));
    gh.lazySingleton<_i231.AuthBloc>(
        () => _i231.AuthBloc(gh<_i7.AuthUseCase>()));
    gh.factory<_i344.CartBloc>(() => _i344.CartBloc(
          gh<_i935.UserRepository>(),
          gh<_i692.AccountRepository>(),
        ));
    gh.lazySingleton<_i358.PageRedirectionCubit>(
        () => _i358.PageRedirectionCubit(gh<_i236.RedirectionUseCase>()));
    gh.factory<_i1059.AdminFourImageOfferCubit>(
        () => _i1059.AdminFourImageOfferCubit(gh<_i42.AdminUseCase>()));
    gh.factory<_i933.UserUseCase>(() => _i933.UserUseCase(
          gh<_i685.AuthRepository>(),
          gh<_i935.UserRepository>(),
        ));
    gh.factory<_i873.WishListCubit>(() => _i873.WishListCubit(
          gh<_i216.AccountUseCase>(),
          gh<_i933.UserUseCase>(),
        ));
    gh.factory<_i1043.FetchAccountScreenDataCubit>(
        () => _i1043.FetchAccountScreenDataCubit(
              gh<_i216.AccountUseCase>(),
              gh<_i933.UserUseCase>(),
            ));
    return this;
  }
}
