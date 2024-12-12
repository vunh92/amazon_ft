import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'admin_add_select_category_state.dart';

@Injectable()
class AdminAddSelectCategoryCubit extends Cubit<AdminAddSelectCategoryState> {
  AdminAddSelectCategoryCubit() : super(AdminAddSelectCategoryInitial());

  void selectCategory({required String category}) async {
    try {
      emit(AdminAddProductsSelectCategory(category: category));
    } catch (e) {
      emit(AdminSelectCategoryErrorS(errorString: e.toString()));
    }
  }

  String? get category {
    if (state is AdminAddProductsSelectCategory) {
      return (state as AdminAddProductsSelectCategory).category;
    } else {
      return null;
    }
  }

  void resetCategory() {
    emit(AdminAddSelectCategoryInitial());
  }
}
