import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../app/common/common.dart';
import '../../domain/model/product.dart';
import '../../domain/repository/category_products_repository.dart';
import '../data_source/api/category_products_api.dart';

@Injectable(as: CategoryProductsRepository)
class CategoryProductsRepositoryImpl extends CategoryProductsRepository {
  late final CategoryProductsApi categoryProductsApi;

  CategoryProductsRepositoryImpl(this.categoryProductsApi);

  @override
  Future<Either<Failure, List<Product>>> fetchCategoryProducts(String category) async {
    await Future.delayed(const Duration(seconds: 1));
    List<Product> productList = [];

    try {
      productList = Constants.mockCategoryProducts.where((element) => element.category == category,).toList();
      return Right(productList);
      http.Response res =
          await categoryProductsApi.fetchCategoryProducts(category);

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

        // return productList;
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }
}
