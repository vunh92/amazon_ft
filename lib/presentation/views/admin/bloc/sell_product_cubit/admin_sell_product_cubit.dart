import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/repository/admin_repository.dart';

part 'admin_sell_product_state.dart';

@Injectable()
class AdminSellProductCubit extends Cubit<AdminSellProductState> {
  final AdminRepository _adminRepository;
  AdminSellProductCubit(this._adminRepository)
      : super(AdminSellProductInitial());

  Future<void> sellProduct({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      emit(AdminSellProductsLoadingS());

      await _adminRepository.adminAddProduct(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: images);

      emit(AdminSellProductSuccessS());
    } catch (e) {
      emit(AdminSellProductErrorS(errorString: e.toString()));
    }
  }
}
