import 'package:amazon_ft/app/common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/model/user.dart';
import '../../../../domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(AuthInitial()) {
    on<TextFieldChangedEvent>(_onTextFieldChangedHandler);
    on<CreateAccountPressedEvent>(_onCreateAccountPressedHandler);
    on<SignInPressedEvent>(_signInPressedHandler);
  }

  void _onTextFieldChangedHandler(
      TextFieldChangedEvent event, Emitter<AuthState> emit) {
    if (event.nameValue == '') {
      emit(TextFieldErrorState(errorString: 'First and last name is required.'));
    } else if (event.emailValue == '' || !isEmailValid(event.emailValue)) {
      emit(TextFieldErrorState(errorString: 'Please enter a valid email address.'));
    } else if (event.passwordValue.length < 6) {
      emit(TextFieldErrorState(errorString: 'Passwords must be at least 6 characters.'));
    } else {
      emit(TextFieldValidState(emailValue: event.emailValue, passwordValue: event.passwordValue));
    }
  }

  void _onCreateAccountPressedHandler(event, emit) async {
    if (event.name == '' || event.email == ''
        || !isEmailValid(event.email) || event.password.length < 6) {
      return;
    }
    emit(AuthLoadingState());

    final either = await _authUseCase.singUpUser(SignUpUseCaseInput(
      event.name,
      event.email,
      event.password,
    ));

    either.fold((l) {
      emit(AuthErrorState(errorString: l.message));
    }, (user) async {
      emit(CreateUserInProgressState(user: user));
      emit(CreateUserSuccessState(
          userCreatedString: 'User Created, you can sign in now!'));
    },);
  }

  void _signInPressedHandler(event, emit) async {
    if(_checkInvalidLoginHandler(event, emit)) return;
    emit(AuthLoadingState());
    final either = await _authUseCase.signInUser(SignInUseCaseInput(
      event.email,
      event.password,
    ));

    either.fold((l) {
      emit(AuthErrorState(errorString: l.message));
    }, (user) {
      emit(UpdateUserData(user: user));
      emit(SignInSuccessState(user: user));
    },);
  }

  bool _checkInvalidLoginHandler(event, emit) {
    return event.email == ''
        || !isEmailValid(event.email)
        || event.password.length < 6;
  }
}
