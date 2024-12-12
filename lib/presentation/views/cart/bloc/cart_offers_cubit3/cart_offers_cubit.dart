import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/model/product.dart';
import '../../../../../domain/repository/account_repository.dart';
import '../../../../../domain/repository/category_products_repository.dart';

part 'cart_offers_state.dart';

@Injectable()
class CartOffersCubit3 extends Cubit<CartOffersState3> {
  final AccountRepository _accountRepository;
  final CategoryProductsRepository _categoryProductsRepository;
  CartOffersCubit3(this._accountRepository, this._categoryProductsRepository) : super(CartOffersInitial3());
  void cartOffers3({required String category}) async {
    try {
      List<Product> productList = [];
      List<double> averageRatingList = [];

      final either = await _categoryProductsRepository.fetchCategoryProducts(category);
      either.fold((l) {

      }, (r) {
        productList = r;
      },);
      productList.shuffle();

      for (int i = 0; i < productList.length; i++) {
        final either = await _accountRepository.getAverageRating(productList[i].id!);
        either.fold((l) {

        }, (r) {
          averageRatingList.add(r);
        },);
      }

      emit(CartOffersSuccessS3(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(CartOffersErrorS3(errorString: e.toString()));
    }
  }
}
