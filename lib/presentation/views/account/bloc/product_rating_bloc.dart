import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../domain/model/order.dart';
import '../../../../domain/model/product.dart';
import '../../../../domain/repository/account_repository.dart';

part 'product_rating_event.dart';
part 'product_rating_state.dart';

@Injectable()
class ProductRatingBloc
    extends Bloc<ProductRatingEventSealed, ProductRatingState> {
  final AccountRepository _accountRepository;
  ProductRatingBloc(this._accountRepository)
      : super(const GetProductRatingInitialS(initialRating: -1)) {
    on<GetProductRatingEvent>(_onGetProductRatingHandler);
    on<RateProductPressedEvent>(_onRateProductPressedHandler);
  }

  Future<List<double>> _getProductRatingList(Order order) async {
    List<double> ratingsList = [];
    for (int i = 0; i < order.products.length; i++) {
      final either = await _accountRepository.getProductRating(order.products[i]);
      either.fold((l) {

      }, (r) {
        ratingsList.add(r);
      },);
    }

    return ratingsList;
  }

  void _onGetProductRatingHandler(event, emit) async {
    try {
      emit(const GetProductRatingInitialS(initialRating: -1));

      List<double> ratingsList = [];
      ratingsList = await _getProductRatingList(event.order);

      emit(GetProductRatingSuccessS(ratingsList: ratingsList));
    } catch (e) {
      emit(GetProductRatingErrorS(errorString: e.toString()));
    }
  }

  // rate product and fetch ratings again
  void _onRateProductPressedHandler(event, emit) async {
    try {
      List<double> ratingsList = [];
      ratingsList = await _getProductRatingList(event.order);
      emit(RateProductInitialS(ratingsList: ratingsList));

      _accountRepository.rateProduct(
          product: event.product, rating: event.rating);

      List<double> updatedRatingsList =
          await _getProductRatingList(event.order);

      emit(RateProductSuccessS(updatedRatingsList: updatedRatingsList));
    } catch (e) {
      emit(RateProductErrorS(errorString: e.toString()));
    }
  }
}
