import 'package:amazon_ft/domain/usecase/account_usecase.dart';
import 'package:amazon_ft/domain/usecase/user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/product.dart';
import '../../common/common.dart';

part 'wish_list_state.dart';

@Injectable()
class WishListCubit extends Cubit<WishListState> {
  final AccountUseCase _accountUseCase;
  final UserUseCase _userUseCase;
  WishListCubit(this._accountUseCase, this._userUseCase) : super(WishListInitial());

  Future getWishList() async {
    try {
      List<Product> wishList = [];
      List<double> averageRatingList = [];

      emit(GetWishListLoadingState());
      
      final eitherWishList = await _accountUseCase.getWishList();
      eitherWishList.fold((fail) {
        emit(GetWishListErrorState(errorString: fail.message));
      }, (data) async {
        wishList = data;
      },);

      for (int i = 0; i < wishList.length; i++) {
        final eitherAverageRating = await _accountUseCase.getAverageRating(wishList[i].id ?? '');
        eitherAverageRating.fold((fail) {
          emit(GetWishListErrorState(errorString: fail.message));
        }, (averageRating) {
          averageRatingList.add(averageRating);
          
        },);
      }

      emit(GetWishListSuccessState(
          wishList: wishList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(GetWishListErrorState(errorString: e.toString()));
    }
  }

  Future wishList({required Product product}) async {
    try {
      emit(GetWishListLoadingState());

      bool isWishListed = false;

      final either = await _accountUseCase.isWishListed(product: product);
      either.fold((l) {
        emit(GetWishListErrorState(errorString: l.message));
      }, (r) {
        isWishListed = r;
        if (isWishListed) {
          emit(AddedToWishListState(product: product));
        } else {
          emit(NotAddedToWishListState(product: product));
        }
      },);
    } catch (e) {
      emit(GetWishListErrorState(errorString: e.toString()));
    }
  }

  Future removedFromWishListScreen({required Product product}) async {
    try {
      List<Product> productList = [];
      List<double> averageRatings = [];

      emit(GetWishListLoadingState());

      bool isDeleted = false;
      final eitherDelete = await _accountUseCase.deleteFromWishList(product: product);
      eitherDelete.fold((fail) {
        emit(GetWishListErrorState(errorString: fail.message));
      },(data) {
        isDeleted = data;
      },);

      if (isDeleted) {
        final eitherWishList = await _accountUseCase.getWishList();
        eitherWishList.fold((l) {
          emit(GetWishListErrorState(errorString: l.message));
        },(r) {
          productList = r;
        },);

        for (int i = 0; i < productList.length; i++) {
          final eitherAverageRating = await _accountUseCase.getAverageRating(productList[i].id ?? '');
          eitherAverageRating.fold((fail) {
            emit(GetWishListErrorState(errorString: fail.message));
          }, (averageRating) {
            averageRatings.add(averageRating);
          },);
        }

        emit(GetWishListSuccessState(
            wishList: productList, averageRatingList: averageRatings));
      }
    } catch (e) {
      emit(GetWishListErrorState(errorString: e.toString()));
    }
  }

  Future addToCartFromWishList({required Product product}) async {
    try {
      List<Product> wishList = [];
      List<double> averageRatingList = [];

      emit(GetWishListLoadingState());

      final eitherAddToCart = await _userUseCase.addToCartFromWishList(product: product);
      eitherAddToCart.fold((fail) {
        emit(GetWishListErrorState(errorString: fail.message));
      },(data) {
        wishList = data;
      },);

      if (wishList.isNotEmpty) {
        for (int i = 0; i < wishList.length; i++) {
          final eitherAverageRating = await _accountUseCase.getAverageRating(wishList[i].id ?? '');
          eitherAverageRating.fold((fail) {
            emit(GetWishListErrorState(errorString: fail.message));
          }, (averageRating) {
            averageRatingList.add(averageRating);
          },);
        }

        emit(GetWishListSuccessState(
            wishList: wishList, averageRatingList: averageRatingList));
      }
    } catch (e) {
      emit(GetWishListErrorState(errorString: e.toString()));
    }
  }

  Future<void> addToWishList({required Product product}) async {
    try {
      final either = await _accountUseCase.addToWishList(product: product);
      either.fold((l) {
        emit(WishListErrorState(errorString: l.message));
      }, (r) {
        emit(AddedToWishListState(product: product));
      },);
    } catch (e) {
      emit(WishListErrorState(errorString: e.toString()));
    }
  }

  Future deleteFromWishList({required Product product}) async {
    try {
      final either = await _accountUseCase.deleteFromWishList(product: product);
      either.fold((l) {
        emit(WishListErrorState(errorString: l.message));
      }, (r) {
        emit(DeletedFromWishListState(product: product));
      },);
    } catch (e) {
      emit(WishListErrorState(errorString: e.toString()));
    }
  }
}
