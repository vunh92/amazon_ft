import 'dart:convert';
import '../model/order.dart';

import 'package:dartz/dartz.dart' hide Order;

import '../../app/common/common.dart';
import '../model/product.dart';

abstract class AccountRepository {
  Future<Either<Failure,List<Order>>> fetchMyOrders();

  Future<Either<Failure,List<Order>>> fetchSearchedOrders(String orderQuery);

  Future<Either<Failure, double>> getProductRating(Product product);

  void rateProduct({required Product product, required double rating});

  Future<Either<Failure, double>> getAverageRating(String productId);

  void addKeepShoppingFor({required Product product});

  Future<Either<Failure,List<Product>>> getKeepShoppingFor();

  Future<Either<Failure,List<Product>>> getWishList();

  Future<Either<Failure, void>> addToWishList({required Product product});

  Future<Either<Failure, bool>> deleteFromWishList({required Product product});

  Future<Either<Failure, bool>> isWishListed({required Product product});

}
