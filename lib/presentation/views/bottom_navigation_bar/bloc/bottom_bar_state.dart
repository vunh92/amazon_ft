part of 'bottom_bar_bloc.dart';

sealed class BottomBarState extends Equatable {
  const BottomBarState();
}

final class BottomBarInitial extends BottomBarState {
  @override
  List<Object> get props => [];
}

class BottomBarPageState extends BottomBarState {
  final int index;

  BottomBarPageState({required this.index});

  @override
  List<Object?> get props => [index];
}

final class BottomBarMoreClickedState extends BottomBarState {
  final int index;
  final bool isOpen;

  BottomBarMoreClickedState(this.index, this.isOpen);

  @override
  List<Object?> get props => [index, isOpen];
}
