import 'package:amazon_ft/domain/usecase/account_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../domain/model/order.dart';
import '../../../../domain/model/product.dart';
import '../../../../domain/model/user.dart';
import '../../../../domain/usecase/user_usecase.dart';

part 'fetch_account_screen_data_state.dart';

@Injectable()
class FetchAccountScreenDataCubit extends Cubit<FetchAccountScreenDataState> {
  final AccountUseCase _accountUseCase;
  final UserUseCase _userUseCase;
  FetchAccountScreenDataCubit(this._accountUseCase, this._userUseCase) : super(FetchAccountScreenDataLoadingState());

  void getAccountScreenData() async {
    try {
      List<Order> ordersList = [];
      List<Order> tempOrdersList = [];
      List<Product> keepShoppingForList = [];
      List<Product> keepShoppingForListTemp = [];
      List<Product> wishListProducts = [];
      List<double> averageRatingList = [];

      final either = await _accountUseCase.fetchMyOrders();
      either.fold((l) {

      }, (data) {
        tempOrdersList = data;
        ordersList = tempOrdersList.reversed.toList();
      },);

      final eitherUser = await _userUseCase.getUserData();
      eitherUser.fold((l) {

      }, (user) async {
        for (int i = 0; i < user.keepShoppingFor.length; i++) {
          keepShoppingForListTemp
              .addAll(user.keepShoppingFor as Iterable<Product>);
          // keepShoppingForListTemp
          //     .add(Product.fromMap(user.keepShoppingFor[i]['product']));
        }
        keepShoppingForList = keepShoppingForListTemp.reversed.toList();

        for (int i = 0; i < user.wishList.length; i++) {
          // Product product = Product.fromMap(user.wishList[i]['product']);
          // wishListProducts.add(product);
          Product product = user.wishList[i];
          wishListProducts.add(product);

          final eitherAverageRating = await _accountUseCase.getAverageRating(product.id!);
          eitherAverageRating.fold((l) {

          }, (averageRating) {
            averageRatingList.add(averageRating);
          },);
        }

        if (ordersList.isEmpty &&
            keepShoppingForList.isEmpty &&
            wishListProducts.isEmpty) {
          emit(const FetchAccountScreenDataEmptyState(
              emptyStringMessage:
              'Your account is currently empty. Start adding items to your orders, wishlist, and history to see them here.'));
        } else {
          emit(FetchAccountScreenDataSuccessState(
            ordersList: ordersList,
            keepShoppingForList: keepShoppingForList,
            wishListProducts: wishListProducts,
            averageRatingList: averageRatingList,
          ));
        }
      },);

    } catch (e) {
      emit(FetchAccountScreenDataErrorState(errorString: e.toString()));
    }
  }
}
