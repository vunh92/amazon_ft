import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'admin_bottom_bar_state.dart';

@Injectable()
class AdminBottomBarCubit extends Cubit<AdminBottomBarState> {
  AdminBottomBarCubit() : super(const AdminBottomBarState(0));

  void adminBottomBar({required int index}) {
    emit(AdminBottomBarState(index));
  }
}
