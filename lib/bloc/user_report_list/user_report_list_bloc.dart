import 'package:bloc/bloc.dart';
import 'package:spanticom/architectures/domain/usecases/UserReportListUseCase.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

import './bloc.dart';

class UserReportListBloc
    extends Bloc<UserReportListBlocEvent, UserReportListBlocState> {
  final UserReportListUseCase userReportListUseCase;

  UserReportListBloc({
    required this.userReportListUseCase,
  }) : super(UserReportListBlocStateOnIdle()) {
    on<UserReportListBlocEvent>((event, emit) async {
      if (event is UserReportListBlocRetrieve) {
        emit(UserReportListBlocStateOnStarted());
        final failureOrTrivia = await userReportListUseCase(event.theFilter);

        try {
          var memberList = await failureOrTrivia.first;

          emit(UserReportListBlocStateOnSuccess(
            memberList,
          ));
        } catch (e) {
          emit(UserReportListBlocStateOnError(e.toString()));
        }
      }
    });
  }
}
