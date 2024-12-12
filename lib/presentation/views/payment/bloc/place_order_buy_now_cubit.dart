import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pay/pay.dart';

import '../../../../domain/model/product.dart';
import '../../../../domain/model/user.dart';
import '../../../../domain/repository/user_repository.dart';

part 'place_order_buy_now_state.dart';

@Injectable()
class PlaceOrderBuyNowCubit extends Cubit<PlaceOrderBuyNowState> {
  final UserRepository _userRepository;
  PlaceOrderBuyNowCubit(this._userRepository)
      : super(PlaceOrderBuyNowInitialS());

  void addPaymentItem({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      final either =  await _userRepository.getUserData();
      either.fold((l) {
        emit(PlaceOrderBuyNowErrorS(errorString: l.message));
      }, (r) {
        emit(PlaceOrderBuyNowProcessS(paymentItems: paymentItemList, user: r));
      },);
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }

  void gPayButton({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];
      User user;

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));
      final either =  await _userRepository.getUserData();
      either.fold((l) {
        emit(PlaceOrderBuyNowErrorS(errorString: l.message));
      }, (r) {
        if (r.address == '') {
          emit(PlaceOrderBuyNowDisableButtonS());
        } else {
          emit(PlaceOrderBuyNowProcessS(
              paymentItems: paymentItemList, user: r));
        }
      },);
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }

  void placeOrderBuyNow(
      {required Product product, required String address}) async {
    try {
      await _userRepository.placeOrderBuyNow(product: product, address: address);
    } catch (e) {
      emit(PlaceOrderBuyNowErrorS(errorString: e.toString()));
    }
  }
}
