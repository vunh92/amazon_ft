import 'package:amazon_ft/domain/model/order.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

import '../../app/common/common.dart';
import '../model/product.dart';
import '../repository/account_repository.dart';
import '../repository/user_repository.dart';

@Injectable()
class AccountUseCase {
  late final AccountRepository _accountRepository;


  AccountUseCase(this._accountRepository);

  Future<Either<Failure, List<Order>>> fetchMyOrders() async {
    return await _accountRepository.fetchMyOrders();
  }

  Future<Either<Failure, double>> getAverageRating(String productId) async {
    return await _accountRepository.getAverageRating(productId);
  }

  Future<Either<Failure, List<Product>>> getWishList() async {
    return await _accountRepository.getWishList();
  }

  Future<Either<Failure, bool>> deleteFromWishList({required Product product}) async {
    return await _accountRepository.deleteFromWishList(product: product);
  }

  Future<Either<Failure, bool>> isWishListed({required Product product}) async {
    return await _accountRepository.isWishListed(product: product);
  }

  Future<Either<Failure, void>> addToWishList({required Product product}) async {
      return await _accountRepository.addToWishList(product: product);
  }
}