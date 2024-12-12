import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

@Injectable()
class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarPageState(index: 0)) {
    on<BottomBarClickedEvent>(_onBottomBarClickedHandler);
    on<BottomBarMoreClickedEvent>(_onBottomBarMoreClickedEvent);
  }

  void _onBottomBarClickedHandler(event, emit) {
    emit(BottomBarPageState(index: event.index));
  }

  void _onBottomBarMoreClickedEvent(event, emit) {
    emit(BottomBarMoreClickedState(event.index, event.isOpen));
  }
}
