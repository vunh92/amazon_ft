import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/common/constants.dart';
import '../../../../../domain/model/product.dart';
import '../../../../../domain/repository/account_repository.dart';
import '../../../../../domain/repository/category_products_repository.dart';
part 'cart_offers_state.dart';

@Injectable()
class CartOffersCubit1 extends Cubit<CartOffersState1> {
  final AccountRepository _accountRepository;
  final CategoryProductsRepository _categoryProductsRepository;
  CartOffersCubit1(this._accountRepository, this._categoryProductsRepository) : super(CartOffersInitial1());

  Future<List<String>> setOfferCategories() async {
    String category1 = '';
    String category2 = '';
    String category3 = '';

    List<Product> productList;

    final either = await _accountRepository.getKeepShoppingFor();
    either.fold((l) {

    },(r) {
      productList = r;
      if (productList.isNotEmpty && productList.length >= 3) {
        for (int i = 0; i < productList.length; i++) {
          if (category1 == '') {
            category1 = productList[i].category;
          } else if (category2 == '' &&
              category1 != '' &&
              category1 != productList[i].category) {
            category2 = productList[i].category;
          } else if (category3 == '' &&
              category1 != '' &&
              category2 != '' &&
              category1 != productList[i].category &&
              category2 != productList[i].category) {
            category3 = productList[i].category;
          }
        }
      } else {
        int index = Random().nextInt(8);
        category1 = Constants.categoryImages[index]['title']!;
        int index1 = Random().nextInt(8);
        category2 = Constants.categoryImages[index1]['title']!;
        int index2 = Random().nextInt(8);
        category3 = Constants.categoryImages[index2]['title']!;
      }
    },);
    return [category1, category2, category3];
  }

  void cartOffers1({required String category}) async {
    try {
      List<Product> productList = [];
      List<double> averageRatingList = [];

      final either = await _categoryProductsRepository.fetchCategoryProducts(category);
      either.fold((l) {

      },(r) {
        productList = r;
      },);
      productList.shuffle();

      for (int i = 0; i < productList.length; i++) {
        final either = await _accountRepository.getAverageRating(productList[i].id!);
        either.fold((l) {

        },(r) {
          averageRatingList.add(r);
        },);
      }

      emit(CartOffersSuccessS1(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(CartOffersErrorS1(errorString: e.toString()));
    }
  }
}
