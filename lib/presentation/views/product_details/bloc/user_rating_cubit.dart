import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/repository/account_repository.dart';

part 'user_rating_state.dart';

@Injectable()
class UserRatingCubit extends Cubit<UserRatingState> {
  final AccountRepository _accountRepository;
  UserRatingCubit(this._accountRepository) : super(UserRatingInitialS());

  void userRating(Product product) async {
    try {
      emit(UserRatingInitialS());

      double rating = 0.0;

      final either = await _accountRepository.getProductRating(product);
      either.fold((l) {
        emit(UserRatingErrorS(errorString: l.message));
      },(r) {
        rating = r;
        emit(UserRatingSuccessS(userRating: rating));
      },);
    } catch (e) {
      emit(UserRatingErrorS(errorString: e.toString()));
    }
  }

  void updateUserRating(
      {required double userRating, required Product product}) async {
    try {
      emit(UpdateUserRatingInitialS());

      _accountRepository.rateProduct(product: product, rating: userRating);

      emit(UpdateUserRatingSuccessS(userRating: userRating));
    } catch (e) {
      emit(UserRatingErrorS(errorString: e.toString()));
    }
  }
}
