import 'package:amazon_ft/app/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/product.dart';

abstract class CategoryProductsRepository {

  Future<Either<Failure, List<Product>>> fetchCategoryProducts(String category);
}
