import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/common/failure.dart';
import '../../data/request/sign_in_request.dart';
import '../../data/request/sign_up_request.dart';
import '../model/user.dart';
import '../repository/auth_repository.dart';

@Injectable()
class AuthUseCase {
  late final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, User>> signInUser(SignInUseCaseInput input) async {
    return await _authRepository.signInUser(
        SignInRequest(input.email, input.password)
    );
  }

  Future<Either<Failure, User>> singUpUser(SignUpUseCaseInput input) async {
    return await _authRepository.singUpUser(
        SignUpRequest(input.name, input.email, input.password)
    );
  }
}

class SignInUseCaseInput {
  String email;
  String password;

  SignInUseCaseInput(this.email, this.password);
}

class SignUpUseCaseInput {
  String name;
  String email;
  String password;

  SignUpUseCaseInput(this.name, this.email, this.password);
}
