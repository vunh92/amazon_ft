import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/usecase/redirection_usecase.dart';

part 'page_redirection_state.dart';

@LazySingleton()
class PageRedirectionCubit extends Cubit<PageRedirectionState> {
  final RedirectionUseCase _redirectionUseCase;

  PageRedirectionCubit(this._redirectionUseCase) : super(PageRedirectionInitial());

  void redirectUser() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final either = await _redirectionUseCase.redirectUser();
      either.fold((l) {
        emit(const PageRedirectionInvalid(isValid: false, userType: 'invalid'));
      }, (r) {
        emit(PageRedirectionSuccess(isValid: true, userType: r.type));
      },);
    } catch (e) {
      emit(const PageRedirectionInvalid(isValid: false, userType: 'invalid'));
      // throw Exception(e.toString());
    }
  }
}
