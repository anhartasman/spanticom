import 'package:bloc/bloc.dart';
import 'package:spanticom/architectures/domain/usecases/FamilyEvaluationHistoryUseCase.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

import './bloc.dart';

class FamilyEvaluationHistoryBloc extends Bloc<FamilyEvaluationHistoryBlocEvent,
    FamilyEvaluationHistoryBlocState> {
  final FamilyEvaluationHistoryUseCase familyEvaluationHistoryUseCase;

  FamilyEvaluationHistoryBloc({
    required this.familyEvaluationHistoryUseCase,
  }) : super(FamilyEvaluationHistoryOnIdle()) {
    on<FamilyEvaluationHistoryBlocEvent>((event, emit) async {
      if (event is FamilyEvaluationHistoryBlocStart) {
        emit(FamilyEvaluationHistoryOnStarted());
        final failureOrTrivia = await familyEvaluationHistoryUseCase(
            FamilyEvaluationHistoryUseCaseParam(
          event.firstDate,
          event.lastDate,
          event.childId,
        ));

        try {
          var resultList = await failureOrTrivia.first;

          emit(FamilyEvaluationHistoryOnSuccess(resultList));
        } catch (e) {
          emit(FamilyEvaluationHistoryOnError(e.toString()));
        }
      }
    });
  }
}
