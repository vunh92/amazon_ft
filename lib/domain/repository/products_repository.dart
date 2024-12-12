import 'package:dartz/dartz.dart';

import '../../app/common/failure.dart';
import '../model/product.dart';

abstract class ProductsRepository {

  Future<Either<Failure, List<Product>>> searchProducts(String searchQuery);

  Future<Either<Failure, int>> getAverageRatingLength({required String productId});

  Future<Either<Failure, Product>> getDealOfTheDay();
}
