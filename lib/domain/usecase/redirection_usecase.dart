import 'dart:convert';

import 'package:amazon_ft/app/common/failure.dart';
import 'package:amazon_ft/domain/model/user.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user_repository.dart';

@Injectable()
class RedirectionUseCase {
  late final UserRepository _userRepository;

  RedirectionUseCase(this._userRepository);
  // Future<Either<Failure, bool>> isTokenValid() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('x-auth-token');
  //   if (token == null) {
  //     prefs.setString('x-auth-token', '');
  //     token = '';
  //   }
  //   return await _authRepository.isTokenValid(token: token);
  // }

  Future<Either<Failure, User>> redirectUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null || token.isEmpty) {
        prefs.setString('x-auth-token', '');
        token = '';
        return Left(Failure(401, 'token null'));
      }

      final userData = prefs.getString('user_data') ?? '';
      final User user = User.fromJson(userData);

      return Right(user);
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

}
