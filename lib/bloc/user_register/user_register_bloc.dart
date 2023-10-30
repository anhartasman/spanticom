import 'package:bloc/bloc.dart';
import 'package:spanticom/architectures/domain/usecases/UserRegisterUseCase.dart';

import './bloc.dart';

class UserRegisterBloc
    extends Bloc<UserRegisterBlocEvent, UserRegisterBlocState> {
  final UserRegisterUseCase userRegisterUseCase;
  UserRegisterBloc({
    required this.userRegisterUseCase,
  }) : super(UserRegisterOnIdle()) {
    on<UserRegisterBlocEvent>((event, emit) async {
      if (event is UserRegisterBlocStart) {
        try {
          emit(UserRegisterOnStarted());

          final failureOrTrivia = await userRegisterUseCase(event.newAccount);

          await failureOrTrivia.first;
          emit(UserRegisterOnSuccess());
        } catch (e) {
          final theErrorMessage = e.toString();
          String labelError = "terjadi kesalahan, silahkan coba lagi";
          if (theErrorMessage.contains("invalid-verification-code")) {
            labelError = "kode OTP salah";
          } else if (theErrorMessage.contains("wrong")) {
            labelError = "Password salah";
          }
          emit(UserRegisterOnError(
            errorMessage: labelError,
          ));
        }
      }
    });
  }
}
