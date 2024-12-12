import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/user.dart';
import '../../../domain/repository/user_repository.dart';

part 'user_state.dart';

@Injectable()
class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserInitial());

  void setUser(User user) {
    emit(UserLoadingState());
    try {
      saveToStorage(user);
      emit(UserSuccessState(user: user.copyWith()));
    } catch (e) {
      emit(UserErrorState(errorString: e.toString()));
    }
  }

  Future<User> getUserData() async {
    final either = await _userRepository.getUserData();
    return either.fold(
      (l) {
        emit(UserErrorState(errorString: l.message));
        return const User(
            id: '',
            name: '',
            email: '',
            password: '',
            address: '',
            type: '',
            token: '',
            cart: [],
            saveForLater: [],
            keepShoppingFor: [],
            wishList: []);
      },
      (r) {
        emit(UserSuccessState(user: r));
        return r;
      },
    );
  }

  User? get currentUser {
    if (state is UserSuccessState) {
      return (state as UserSuccessState).user;
    } else {
      return null;
    }
  }

  void updateUser(User updatedUser) {
    emit(UserLoadingState());
    try {
      saveToStorage(updatedUser);

      emit(UserSuccessState(user: updatedUser.copyWith()));
    } catch (e) {
      emit(UserErrorState(errorString: e.toString()));
    }
  }

  void saveUserAddress({required String address}) async {
    try {
      final either = await _userRepository.saveUserAddress(address: address);
      either.fold((l) {
        emit(UserErrorState(errorString: l.message));
      }, (user) {
        updateUser(user);

      },);
    } catch (e) {
      emit(UserErrorState(errorString: e.toString()));
    }
  }

  UserState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json['user']);
      return UserSuccessState(user: user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserSuccessState) {
      return {'user': state.user.toJson()};
    } else {
      return {};
    }
  }

  void saveToStorage(User updatedUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', updatedUser.copyWith().toJson());
    await prefs.setString('x-auth-token', updatedUser.token);
    // await HydratedBloc.storage
    //     .write('user_data', updatedUser.copyWith().toJson());
  }
}
