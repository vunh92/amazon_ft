import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pay/pay.dart';

import '../../../../domain/model/user.dart';
import '../../../../domain/repository/user_repository.dart';

part 'order_state.dart';

@Injectable()
class OrderCubit extends Cubit<OrderState> {
  final UserRepository _userRepository;
  OrderCubit(this._userRepository) : super(OrderInitialS());

  Future addPaymentItem({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      final eitherUser = await _userRepository.getUserData();
      eitherUser.fold((l) {
        emit(OrderErrorS(errorString: l.message));
      },(r) {
        emit(OrderProcessS(paymentItems: paymentItemList, user: r));
      },);
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
    }
  }

  Future gPayButton({required String totalAmount}) async {
    try {
      List<PaymentItem> paymentItemList = [];

      paymentItemList.add(PaymentItem(
          amount: totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price));

      final eitherUser = await _userRepository.getUserData();
      eitherUser.fold((l) {
        emit(OrderErrorS(errorString: l.message));
      },(r) {
        if (r.address == '') {
          emit(DisableButtonS());
        } else {
          emit(OrderProcessS(paymentItems: paymentItemList, user: r));
        }
      },);
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
    }
  }

  Future<void> placeOrder(
      {required String address, required double totalAmount}) async {
    try {
      final either = await _userRepository.placeOrder(
          totalPrice: totalAmount,
          address: address
      );
      either.fold((l) {
        emit(OrderErrorS(errorString: l.message));
      }, (r) {

      },);
    } catch (e) {
      emit(OrderErrorS(errorString: e.toString()));
    }
  }
}
