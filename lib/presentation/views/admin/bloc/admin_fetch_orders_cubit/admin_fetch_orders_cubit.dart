import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../../../domain/model/order.dart';
import '../../../../../domain/repository/admin_repository.dart';

part 'admin_fetch_orders_state.dart';

@Injectable()
class AdminFetchOrdersCubit extends Cubit<AdminFetchOrdersState> {
  final AdminRepository _adminRepository;
  AdminFetchOrdersCubit(this._adminRepository)
      : super(AdminFetchOrdersLoadingS());

  void adminFetchOrders() async {
    try {
      List<Order> ordersList = [];
      // List<Order> tempOrdersList;

      emit(AdminFetchOrdersLoadingS());

      final either = await _adminRepository.adminGetOrders();
      either.fold((l) {

      },(r) {
        ordersList = r.reversed.toList();
      },);
      emit(AdminFetchOrdersSuccessS(ordersList: ordersList));
    } catch (e) {
      emit(AdminFetchOrdersErrorS(errorString: e.toString()));
    }
  }
}
