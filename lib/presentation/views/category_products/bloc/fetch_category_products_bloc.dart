import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/repository/account_repository.dart';
import '../../../../domain/repository/category_products_repository.dart';

part 'fetch_category_products_event.dart';
part 'fetch_category_products_state.dart';

@LazySingleton()
class FetchCategoryProductsBloc
    extends Bloc<FetchCategoryProductsEvent, FetchCategoryProductsState> {
  final CategoryProductsRepository _categoryProductRepository;
  final AccountRepository _accountRepository;
  FetchCategoryProductsBloc(this._categoryProductRepository, this._accountRepository)
      : super(FetchCategoryProductsLoadingS()) {
    on<FetchCategoryProductsEvent>(_onFetchCategoryProductsHandler);
    on<CategoryPressedEvent>(_onFetchCategoryProductsHandler);
  }

  void _onFetchCategoryProductsHandler(event, emit) async {
    try {
      List<Product> productList = [];
      List<double> averageRatingList = [];
      double rating;
      emit(FetchCategoryProductsLoadingS());

      final either = await _categoryProductRepository.fetchCategoryProducts(event.category);

      either.fold((l) {
        emit(FetchCategoryProductsErrorS(errorString: l.message));
      },(r) {
        productList = r;
        // productList.shuffle();
      },);

      for (int i = 0; i < productList.length; i++) {
        final eitherRating = await _accountRepository.getAverageRating(productList[i].id!);
        eitherRating.fold((l) {
          log(l.message);
        },(r) {
          averageRatingList.add(r);
        },);
      }

      emit(FetchCategoryProductsSuccessS(
          productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(FetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }
}
