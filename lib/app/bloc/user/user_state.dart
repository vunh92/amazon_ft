part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserSuccessState extends UserState {
  final User user;

  UserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class UserErrorState extends UserState {
  final String errorString;

  UserErrorState({required this.errorString});
  @override
  List<Object> get props => [errorString];
}