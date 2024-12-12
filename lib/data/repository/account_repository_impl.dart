import 'dart:convert';

import 'package:amazon_ft/app/common/failure.dart';
import 'package:amazon_ft/domain/model/order.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart' hide Order;

import '../../app/common/constants.dart';
import '../../domain/model/product.dart';
import '../../domain/repository/account_repository.dart';
import '../data_source/api/account_api.dart';

@Injectable(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  late final AccountApi _accountApi;

  AccountRepositoryImpl(this._accountApi);

  @override
  Future<Either<Failure, List<Order>>> fetchMyOrders() async {
    try {
      List<Order> myOrderList = [];
      await Future.delayed(const Duration(seconds: 1));
      myOrderList.addAll(Constants.mockOrderList);
      return Right(myOrderList);
      // http.Response res = await accountApi.fetchMyOrders();
      // if (res.statusCode == 200) {
      //   for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //     myOrderList.add(
      //       Order.fromJson(
      //         jsonEncode(
      //           jsonDecode(res.body)[i],
      //         ),
      //       ),
      //     );
      //   }
      //   return Right(myOrderList);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> fetchSearchedOrders(String orderQuery) async {
    try {
      List<Order> searchedOrderList = [];
      await Future.delayed(const Duration(milliseconds: 100));
      return Right(Constants.mockSearchOrders);
      // http.Response res = await _accountApi.searchOrders(orderQuery);
      //
      // if (res.statusCode == 200) {
      //   for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //     searchedOrderList.add(
      //       Order.fromJson(
      //         jsonEncode(
      //           jsonDecode(res.body)[i],
      //         ),
      //       ),
      //     );
      //   }
      //
      //   return Right(searchedOrderList);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getProductRating(Product product) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return const Right(3.5);
      http.Response res = await _accountApi.getProductRating(product);

      if (res.statusCode == 200) {
        double rating = jsonDecode(res.body).toDouble();
        return Right(rating);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getAverageRating(String productId) async {
    try {
      double averageRating = 0;
      return const Right(2.0);
      // http.Response res = await accountApi.getAverageRating(productId);
      //
      // if (res.statusCode == 200) {
      //   averageRating = jsonDecode(res.body).toDouble();
      //
      //   return Right(averageRating);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  void rateProduct({required Product product, required double rating}) async {
    try {
      http.Response res =
          await _accountApi.rateProduct(product: product, rating: rating);

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void addKeepShoppingFor({required Product product}) async {
    try {
      await _accountApi.addKeepShoppingFor(product: product);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getKeepShoppingFor() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(Constants.mockKeepShoppingForList);
      List<Product> productList = [];

      http.Response res = await _accountApi.getKeepShoppingFor();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(productList);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getWishList() async {
    try {
      List<Product> wishList = [];
      await Future.delayed(const Duration(milliseconds: 100));
      return Right(Constants.mockWishList);

      // http.Response res = await _accountApi.getWishList();
      //
      // if (res.statusCode == 200) {
      //   for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //     wishList.add(
      //       Product.fromJson(
      //         jsonEncode(
      //           jsonDecode(res.body)[i],
      //         ),
      //       ),
      //     );
      //   }
      //
      //   return Right(wishList);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToWishList({required Product product}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(Function);
      http.Response res = await _accountApi.addToWishList(product: product);

      if (res.statusCode != 200) {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFromWishList({required Product product}) async {
    try {
      bool isDeleted = false;

      await Future.delayed(const Duration(seconds: 1));

      return Right(isDeleted);
      http.Response res = await _accountApi.deletFromWishList(product: product);

      if (res.statusCode == 200) {
        isDeleted = true;
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
      return Right(isDeleted);
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isWishListed({required Product product}) async {
    try {
      return const Right(true);
      http.Response res = await _accountApi.isWishListed(product: product);

      if (res.statusCode == 200) {
        return Right(jsonDecode(res.body));
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

}
