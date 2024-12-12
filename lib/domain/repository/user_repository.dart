import 'package:dartz/dartz.dart' hide Order;

import '../../app/common/failure.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserDataInitial(var token);

  Future<Either<Failure, User>> getUserData();

  Future<Either<Failure, User>> saveUserAddress({required String address});

  Future<Either<Failure, List<Product>>> addToCartFromWishList({required Product product});

  Future<Either<Failure, List<dynamic>>> removeFromCart({required Product product});

  Future<Either<Failure, List<dynamic>>> deleteFromCart({required Product product});

  Future<Either<Failure, List<dynamic>>> saveForLater({required Product product});

  Future<Either<Failure, List<Product>>> getSaveForLater();

  Future<Either<Failure, List<dynamic>>> deleteFromLater({required Product product});

  Future<Either<Failure, List<dynamic>>> moveToCart({required Product product});

  Future<Either<Failure, List<dynamic>>> addToCart({required Product product});

  Future<Either<Failure, List<dynamic>>> getCart();

  Future<Either<Failure, Order>> placeOrder({required String address, required double totalPrice});

  Future<Either<Failure, bool>> placeOrderBuyNow({required Product product, required String address});

}
