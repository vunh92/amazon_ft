part of 'fetch_account_screen_data_cubit.dart';

sealed class FetchAccountScreenDataState extends Equatable {
  const FetchAccountScreenDataState();
}

final class FetchAccountScreenDataLoadingState
    extends FetchAccountScreenDataState {
  @override
  List<Object?> get props => [];}

// final class FetchAccountScreenDataInitial extends FetchAccountScreenDataState {
//   @override
//   List<Object> get props => [];
// }

final class FetchAccountScreenDataSuccessState extends FetchAccountScreenDataState {
  final List<Order> ordersList;
  final List<Product> keepShoppingForList;
  final List<Product> wishListProducts;
  final List<double> averageRatingList;

  const FetchAccountScreenDataSuccessState({
    required this.ordersList,
    required this.keepShoppingForList,
    required this.wishListProducts,
    required this.averageRatingList,
  });

  @override
  List<Object> get props =>
      [ordersList, keepShoppingForList, wishListProducts, averageRatingList];
}

final class FetchAccountScreenDataErrorState extends FetchAccountScreenDataState {
  final String errorString;

  const FetchAccountScreenDataErrorState({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

final class FetchAccountScreenDataEmptyState extends FetchAccountScreenDataState {
  final String emptyStringMessage;

  const FetchAccountScreenDataEmptyState({required this.emptyStringMessage});

  @override
  List<Object> get props => [emptyStringMessage];
}
