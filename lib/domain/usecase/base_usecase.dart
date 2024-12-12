import 'package:dartz/dartz.dart';

import '../../app/common/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
