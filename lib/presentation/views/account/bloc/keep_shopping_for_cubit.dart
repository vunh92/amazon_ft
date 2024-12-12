import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/repository/account_repository.dart';

part 'keep_shopping_for_state.dart';

@Injectable()
class KeepShoppingForCubit extends Cubit<KeepShoppingForState> {
  final AccountRepository _accountRepository;
  KeepShoppingForCubit(this._accountRepository)
      : super(KeepShoppingForLoadingS());

  void keepShoppingFor() async {
    try {
      List<Product> tempKeepShoppingForList;
      List<Product> keepShoppingForList = [];
      List<double> averageRatingList = [];

      final eitherList = await _accountRepository.getKeepShoppingFor();
      eitherList.fold((l) {

      },(r) {
        tempKeepShoppingForList = r;
        keepShoppingForList = tempKeepShoppingForList.reversed.toList();
      },);

      for (int i = 0; i < keepShoppingForList.length; i++) {
        final either = await _accountRepository.getAverageRating(keepShoppingForList[i].id!);
        either.fold((l) {

        }, (r) {
          averageRatingList.add(r);
        },);
      }

      emit(KeepShoppingForSuccessS(
          productList: keepShoppingForList,
          averageRatingList: averageRatingList));
    } catch (e) {
      emit(KeepShoppingForErrorS(errorString: e.toString()));
    }
  }

  void addToKeepShoppingFor({required Product product}) async {
    try {
      _accountRepository.addKeepShoppingFor(product: product);

      emit(AddKeepShoppingForSuccessS(product: product));
    } catch (e) {
      emit(AddKeepShoppingForErrorS(errorString: e.toString()));
    }
  }
}
