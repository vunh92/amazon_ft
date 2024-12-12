import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../domain/model/order.dart';
import '../../../../domain/repository/account_repository.dart';

part 'fetch_orders_state.dart';

@Injectable()
class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  final AccountRepository _accountRepository;

  FetchOrdersCubit(this._accountRepository) : super(FetchOrdersLoadingAS());

  void fetchOrders() async {
    try {
      List<Order> ordersList;

      emit(FetchOrdersLoadingAS());

      final either = await _accountRepository.fetchMyOrders();
      either.fold((l) {
        emit(FetchOrdersErrorAS(errorString: l.message));
      },(r) {
        ordersList = r;
        emit(FetchOrdersSuccessAS(ordersList: ordersList));
      },);
    } catch (e) {
      emit(FetchOrdersErrorAS(errorString: e.toString()));
    }
  }

  void fetchSearchedOrders(String orderQuery) async {
    try {
      emit(FetchSearchedOrdersLoadingS());

      final either = await _accountRepository.fetchSearchedOrders(orderQuery);
      either.fold((l) {
        emit(FetchOrdersErrorAS(errorString: l.message));
      },(r) {
        emit(FetchSearchedOrdersSuccessS(searchedOrdersList: r));
      },);
    } catch (e) {
      emit(FetchOrdersErrorAS(errorString: e.toString()));
    }
  }
}
