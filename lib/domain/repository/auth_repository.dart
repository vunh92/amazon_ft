import 'package:dartz/dartz.dart';

import '../../app/common/failure.dart';
import '../../data/request/sign_in_request.dart';
import '../../data/request/sign_up_request.dart';
import '../model/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> singUpUser(SignUpRequest signUpRequest);

  Future<Either<Failure, User>> signInUser(SignInRequest signInRequest);

  Future<Either<Failure, bool>> isTokenValid({required var token});
}
