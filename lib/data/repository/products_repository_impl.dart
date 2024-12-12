import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../app/common/common.dart';
import '../../domain/model/product.dart';
import '../../domain/repository/products_repository.dart';
import '../data_source/api/products_api.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsApi _productsApi;

  ProductsRepositoryImpl(this._productsApi);

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String searchQuery) async {
    List<Product> productList = [];

    try {
      http.Response res = await _productsApi.searchProducts(searchQuery);

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
  Future<Either<Failure, int>> getAverageRatingLength({required String productId}) async {
    try {
      http.Response res =
          await _productsApi.getAverageRatingLength(productId: productId);

      if (res.statusCode == 200) {
        int getAverageRatingLength = jsonDecode(res.body);

        return Right(getAverageRatingLength);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getDealOfTheDay() async {
    try {
      return Right(Constants.mockProductDealOfDay);
      Product product;
      http.Response res = await _productsApi.getDealOfTheDay();

      if (res.statusCode == 200) {
        product = Product.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );

        return Right(product);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }
}
