import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/repository/products_repository.dart';

part 'deal_of_the_day_state.dart';

@Injectable()
class DealOfTheDayCubit extends Cubit<DealOfTheDayState> {
  final ProductsRepository _productsRepository;
  DealOfTheDayCubit(this._productsRepository) : super(DealOfTheDayInitialS());

  Future<void> getDealOfTheDay(int? imageIndex) async {
    try {
      final either = await _productsRepository.getDealOfTheDay();
      either.fold((l) {
        emit(DealOfTheDayErrorS(errorString: l.message));
      }, (r) {
        emit(DealOfTheDaySuccessS(product: r, imageIndex: imageIndex!));
      },);
    } catch (e) {
      emit(DealOfTheDayErrorS(errorString: e.toString()));
    }
  }

  void changeDealOfTheDayImage(int index) {
    Product product = (state as DealOfTheDaySuccessS).product;

    emit(DealOfTheDaySuccessS(product: product, imageIndex: index));
  }
}
