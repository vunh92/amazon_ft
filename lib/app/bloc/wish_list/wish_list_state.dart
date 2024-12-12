part of 'wish_list_cubit.dart';

sealed class WishListState extends Equatable {
  const WishListState();
}

final class WishListInitial extends WishListState {
  @override
  List<Object> get props => [];
}

// Get keep shopping for
final class GetWishListLoadingState extends WishListState {
  @override
  List<Object?> get props => [];
}

final class GetWishListSuccessState extends WishListState {
  final List<Product> wishList;
  final List<double> averageRatingList;

  const GetWishListSuccessState(
      {required this.wishList, required this.averageRatingList});

  @override
  List<Object> get props => [wishList];
}

final class GetWishListErrorState extends WishListState {
  final String errorString;

  const GetWishListErrorState({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// product details screen - wishlist

class NotAddedToWishListState extends WishListState {
  final Product product;

  const NotAddedToWishListState({required this.product});

  @override
  List<Object> get props => [product];
}

class AddedToWishListState extends WishListState {
  final Product product;

  const AddedToWishListState({required this.product});

  @override
  List<Object> get props => [product];
}

class DeletedFromWishListState extends WishListState {
  final Product product;

  const DeletedFromWishListState({required this.product});

  @override
  List<Object> get props => [product];
}

// class AddToWishListSuccessState extends WishListState {}

class WishListErrorState extends WishListState {
  final String errorString;

  const WishListErrorState({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// wish list screen

final class LoadingWishListScreenState extends WishListState {
  @override
  List<Object?> get props => [];
}

final class AddedToCartWishListScreenState extends WishListState {
  @override
  List<Object?> get props => [];
}

final class RemovedFromWishListScreenState extends WishListState {
  @override
  List<Object?> get props => [];
}
