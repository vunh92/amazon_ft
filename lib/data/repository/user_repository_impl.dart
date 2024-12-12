import 'dart:convert';
import 'package:amazon_ft/app/common/constants.dart';
import 'package:amazon_ft/domain/model/product.dart';
import 'package:amazon_ft/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart' hide Order;

import '../../app/common/failure.dart';
import '../../domain/model/order.dart';
import '../../domain/model/user.dart';
import '../data_source/api/user_api.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl(this._userApi);

  @override
  Future<Either<Failure, User>> getUserDataInitial(var token) async {
    try {
      http.Response res = await _userApi.getUserDataInitial(token);

      if (res.statusCode == 200) {
        User user = User.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );
        return Right(user);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
        // throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
      // throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, User>> getUserData() async {
    try {
      return Right(Constants.mockUser);
      // http.Response res = await userApi.getUserData();
      //
      // if (res.statusCode == 200) {
      //   User user = User.fromJson(
      //     jsonEncode(
      //       jsonDecode(res.body),
      //     ),
      //   );
      //   return Right(user);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> saveUserAddress(
      {required String address}) async {
    try {
      http.Response res = await _userApi.saveUserAddress(address: address);

      if (res.statusCode == 200) {
        User user = User.fromJson(
          jsonEncode(
            jsonEncode(res.body),
          ),
        );

        return Right(user);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> addToCartFromWishList(
      {required Product product}) async {
    try {
      List<Product> wishList = [];

      http.Response res =
          await _userApi.addToCartFromWishList(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          wishList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(wishList);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> removeFromCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];
      return Right([cartProducts, productQuantity]);
      http.Response res = await _userApi.removeFromCart(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(jsonDecode(res.body)[i]['quantity']);
        }

        return Right([cartProducts, productQuantity]);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> deleteFromCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];
      return Right([cartProducts, productQuantity]);

      http.Response res = await _userApi.deleteFromCart(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(jsonDecode(res.body)[i]['quantity']);
        }

        return Right([cartProducts, productQuantity]);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> saveForLater({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];
      return Right([cartProducts, productQuantity]);

      http.Response res = await _userApi.saveForLater(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return Right([cartProducts, productQuantity]);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getSaveForLater() async {
    try {
      List<Product> saveForLaterProducts = [];
      await Future.delayed(const Duration(milliseconds: 200));
      return Right(saveForLaterProducts);

      // http.Response res = await _userApi.getSaveForLater();
      //
      // if (res.statusCode == 200) {
      //   for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //     saveForLaterProducts.add(
      //       Product.fromJson(
      //         jsonEncode(
      //           jsonDecode(res.body)[i]['product'],
      //         ),
      //       ),
      //     );
      //   }
      //   return Right(saveForLaterProducts);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<dynamic>>> deleteFromLater({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];
      return Right([cartProducts, productQuantity]);

      http.Response res = await _userApi.deleteFromLater(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return Right([cartProducts, productQuantity]);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> moveToCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];
      return Right([cartProducts, productQuantity]);

      http.Response res = await _userApi.moveToCart(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return Right([cartProducts, productQuantity]);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> addToCart(
      {required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      await Future.delayed(const Duration(milliseconds: 300));

      return Right([cartProducts, productQuantity]);

      // http.Response res = await _userApi.addToCart(product: product);
      //
      // if (res.statusCode == 200) {
      //   for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //     cartProducts.add(
      //       Product.fromJson(
      //         jsonEncode(
      //           jsonDecode(res.body)[i]['product'],
      //         ),
      //       ),
      //     );
      //     productQuantity.add(jsonDecode(res.body)[i]['quantity']);
      //   }
      //   return Right([cartProducts, productQuantity]);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getCart() async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      await Future.delayed(const Duration(milliseconds: 300));

      return Right([Constants.mockProductList, [10, 20, 30, 40]]);

      // http.Response res = await _userApi.getCart();
      //
      // if (res.statusCode == 200) {
      // for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //   cartProducts.add(
      //     Product.fromJson(
      //       jsonEncode(
      //         jsonDecode(res.body)[i]['product'],
      //       ),
      //     ),
      //   );
      //   productQuantity.add(
      //     jsonDecode(res.body)[i]['quantity'],
      //   );
      // }
      //   return Right([cartProducts, productQuantity]);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> placeOrder(
      {required String address, required double totalPrice}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(Constants.mockOrder);
      // http.Response res =
      //     await _userApi.placeOrder(totalPrice: totalPrice, address: address);
      //
      // if (res.statusCode == 200) {
      //   Order order = Order.fromJson(
      //     jsonEncode(
      //       jsonDecode(res.body),
      //     ),
      //   );
      //   return Right(order);
      // } else {
      //   return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      // }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> placeOrderBuyNow(
      {required Product product, required String address}) async {
    try {
      return const Right(true);
      http.Response res =
          await _userApi.placeOrderBuyNow(product: product, address: address);

      if (res.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }
}
