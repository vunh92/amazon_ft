import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repository/account_repository.dart';
import '../../../../domain/repository/products_repository.dart';

part 'average_rating_state.dart';

@Injectable()
class AverageRatingCubit extends Cubit<AverageRatingState> {
  final AccountRepository _accountRepository;
  final ProductsRepository _productsRepository;
  AverageRatingCubit(this._accountRepository, this._productsRepository) : super(AverageRatingLoadingS());

  void getProductAverageRating({required String productId}) async {
    try {
      emit(AverageRatingLoadingS());
      int averageRatingLength = 1;
      double averageRating = 0.0;

      final either = await _accountRepository.getAverageRating(productId);
      either.fold((l) {
        log(l.message);
      },(r) {
        averageRating = r;
      },);

      final eitherLength = await _productsRepository.getAverageRatingLength(productId: productId);
      eitherLength.fold((l) {
        log(l.message);
      },(r) {
        averageRatingLength = r;
      },);

      emit(AverageRatingSuccessS(
          averageRating: averageRating,
          averageRatingLength: averageRatingLength));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
