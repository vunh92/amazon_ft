import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/repository/account_repository.dart';
import '../../../../domain/repository/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@Injectable()
class CartBloc extends Bloc<CartEvent, CartState> {
  final UserRepository _userRepository;
  final AccountRepository _accountRepository;
  CartBloc(this._userRepository, this._accountRepository) : super(CartLoadingS()) {
    on<GetCartPressed>(_onGetCartHandler);
    on<AddToCart>(_onAddToCartHandler);
    on<AddToCartFromBottomSheet>(_onAddToCartFromBottomSheetHandler);
    on<RemoveFromCart>(_onRemoveFromCartHandler);
    on<DeleteFromCart>(_onDeleteFromCartHandler);
    on<SaveForLaterE>(_onSaveForLaterHandler);
    on<DeleteFromLaterE>(_onDeleteFromLaterHandler);
    on<MoveToCartE>(_onMoveToCartHandler);
  }

  Future<List<dynamic>> tryBlockCode({required dynamic customUserRepository}) async {
    List<dynamic> items;
    List<Product> cartProducts;
    List<Product> saveForLaterProducts = [];
    List<int> productsQuantity;
    List<double> averageRatingList = [];
    double rating = 0.0;
    double sum = 0;

    items = await customUserRepository;
    cartProducts = items[0] as List<Product>;
    productsQuantity = items[1] as List<int>;

    final eitherSave = await _userRepository.getSaveForLater();
    eitherSave.fold((l) {

    },(r) {
      saveForLaterProducts = r;
    },);

    for (int i = 0; i < cartProducts.length; i++) {
      sum += cartProducts[i].price * productsQuantity[i];
      final either = await _accountRepository.getAverageRating(cartProducts[i].id!);
      either.fold((l) {

      },(r) {
        rating = r;
      },);

      averageRatingList.add(rating);
    }

    return [
      sum,
      cartProducts,
      averageRatingList,
      productsQuantity,
      saveForLaterProducts
    ];
  }

  void _onGetCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.getCart();
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onAddToCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.addToCart(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onAddToCartFromBottomSheetHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.addToCart(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onRemoveFromCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.removeFromCart(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onDeleteFromCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.deleteFromCart(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onSaveForLaterHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.saveForLater(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onDeleteFromLaterHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.deleteFromLater(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onMoveToCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> tempItems = [];
      final either = await _userRepository.moveToCart(product: event.product);
      either.fold((l) {
        emit(CartProductErrorS(errorString: l.message));
      }, (r) {
        tempItems = r;
      },);
      List<dynamic> items = await tryBlockCode(customUserRepository: tempItems);
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  int get cartItemsLength {
    if (state is CartProductSuccessS) {
      return (state as CartProductSuccessS).cartProducts.length;
    } else {
      return -1;
    }
  }
}
