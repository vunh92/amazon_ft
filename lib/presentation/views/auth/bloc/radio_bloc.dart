import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'radio_event.dart';
part 'radio_state.dart';

enum Auth { signIn, signUp }

@Injectable()
class RadioBloc extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(RadioInitial()) {
    on<RadioEvent>((event, emit) {
      _onRadioChangedHandler(event, emit);
    });
  }

  void _onRadioChangedHandler(event, emit) {
    if (event.auth == Auth.signIn) {
      emit(RadioSignInState(auth: event.auth));
    } else {
      emit(RadioSignUpState(auth: event.auth));
    }
  }
}
