import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/model/product.dart';
import '../../../../../domain/repository/admin_repository.dart';

part 'admin_fetch_category_products_event.dart';
part 'admin_fetch_category_products_state.dart';

@Injectable()
class AdminFetchCategoryProductsBloc extends Bloc<
    AdminFetchCategoryProductsEvent, AdminFetchCategoryProductsState> {
  final AdminRepository _adminRepository;
  AdminFetchCategoryProductsBloc(this._adminRepository)
      : super(AdminFetchCategoryProductsLoadingS()) {
    on<AdminFetchCategoryProductsPressedE>(
        _onAdminFetchCategoryProductsHandler);
    on<AdminDeleteProductPressedE>(_onAdminDeleteProductHandler);
  }

  void _onAdminFetchCategoryProductsHandler(event, emit) async {
    try {
      List<Product> categoryProducts = [];
      emit(AdminFetchCategoryProductsLoadingS());

      final either = await _adminRepository.adminGetCategoryProducts(
          category: event.category);
      either.fold((l) {

      },(r) {
        categoryProducts = r.reversed.toList();
      },);

      emit(AdminFetchCategoryProductsSuccessS(
          categoryProducts: categoryProducts));
    } catch (e) {
      emit(AdminFetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }

  Future<void> _onAdminDeleteProductHandler(event, emit) async {
    try {
      emit(AdminFetchCategoryProductsLoadingS());

      List<Product> categoryProducts = [];
      await _adminRepository.adminDeleteProduct(product: event.product);

      final either = await _adminRepository.adminGetCategoryProducts(
          category: event.category);
      either.fold((l) {

      },(r) {
        categoryProducts = r.reversed.toList();
      },);

      emit(AdminFetchCategoryProductsSuccessS(
          categoryProducts: categoryProducts));
    } catch (e) {
      emit(AdminFetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }
}
