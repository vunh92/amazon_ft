import 'package:amazon_ft/app/common/failure.dart';
import 'package:amazon_ft/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product.dart';
import '../model/user.dart';
import '../repository/auth_repository.dart';

@Injectable()
class UserUseCase {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  UserUseCase(this._authRepository, this._userRepository);

  Future<Either<Failure, bool>> redirectUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token == null) {
      prefs.setString('x-auth-token', '');
      token = '';
    }
    return await _authRepository.isTokenValid(token: token);
  }

  Future<Either<Failure, User>> getUserData() async {
    return await _userRepository.getUserData();
  }

  Future<Either<Failure, List<Product>>> addToCartFromWishList({required Product product}) async {
    return await _userRepository.addToCartFromWishList(product: product);
  }

}