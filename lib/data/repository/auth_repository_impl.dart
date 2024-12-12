import 'dart:convert';

import 'package:amazon_ft/app/common/constants.dart';
import 'package:amazon_ft/domain/model/user.dart';
import 'package:amazon_ft/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../app/common/failure.dart';
import '../data_source/api/auth_api.dart';
import '../request/sign_in_request.dart';
import '../request/sign_up_request.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthAPI _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  Future<Either<Failure, bool>> isTokenValid({required token}) async {
    try {
      http.Response res = await AuthAPI().isTokenValid(token: token);

      if (res.statusCode == 200) {
        bool isTokenValid = jsonDecode(res.body);

        return Right(isTokenValid);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
        // throw jsonDecode(res.body)['msg'];
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
      // throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, User>> signInUser(SignInRequest signInRequest) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (Constants.mockUser.email == signInRequest.email
          && Constants.mockUser.password == signInRequest.password) {
        return Right(Constants.mockUser);
      }
      if (Constants.mockAdmin.email == signInRequest.email
          && Constants.mockAdmin.password == signInRequest.password) {
        return Right(Constants.mockAdmin);
      }
      return Left(Failure(201, 'Error email or password'));

      final http.Response res = await _authApi.signInUser(signInRequest);

      if (res.statusCode == 200) {
        User user = User.fromMap(jsonDecode(res.body));

        return Right(user);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
        // throw jsonDecode(res.body)['msg'];
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
      // throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, User>> singUpUser(SignUpRequest signUpRequest) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (Constants.mockUser.email == signUpRequest.email) {
        return Left(Failure(201, 'Account is exist!'));
      }

      if (Constants.mockAdmin.email == signUpRequest.email) {
        return Left(Failure(201, 'Account is exist!'));
      }

      var user = User(
        id: signUpRequest.email,
        name: signUpRequest.name,
        email: signUpRequest.email,
        password: signUpRequest.password,
        address: '',
        type: 'user',
        token: 'token_user',
        cart: const [],
        saveForLater: const [],
        keepShoppingFor: const [],
        wishList: const [],
      );

      return Right(user);

      http.Response res = await _authApi.signUpUser(signUpRequest);

      if (res.statusCode == 200) {
        User user = User.fromMap(jsonDecode(res.body));
        return Right(user);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
        // throw jsonDecode(res.body)['msg'];
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
      // throw Exception(e.toString());
    }
  }

}