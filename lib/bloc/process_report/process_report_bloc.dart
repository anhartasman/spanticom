import 'package:bloc/bloc.dart';
import 'package:spanticom/architectures/domain/usecases/ProcessReportUseCase.dart';

import './bloc.dart';

class ProcessReportBloc
    extends Bloc<ProcessReportBlocEvent, ProcessReportBlocState> {
  final ProcessReportUseCase processReportUseCase;
  ProcessReportBloc({
    required this.processReportUseCase,
  }) : super(ProcessReportBlocStateOnIdle()) {
    on<ProcessReportBlocEvent>((event, emit) async {
      if (event is ProcessReportBlocStart) {
        try {
          emit(ProcessReportBlocStateOnStarted());

          final failureOrTrivia =
              await processReportUseCase(event.reportChange);

          await failureOrTrivia.first;
          emit(ProcessReportBlocStateOnSuccess());
        } catch (e) {
          final theErrorMessage = e.toString();
          String labelError = "terjadi kesalahan, silahkan coba lagi";
          if (theErrorMessage.contains("invalid-verification-code")) {
            labelError = "kode OTP salah";
          } else if (theErrorMessage.contains("wrong")) {
            labelError = "Password salah";
          }
          emit(ProcessReportBlocStateOnError(
            errorMessage: labelError,
          ));
        }
      }
    });
  }
}
