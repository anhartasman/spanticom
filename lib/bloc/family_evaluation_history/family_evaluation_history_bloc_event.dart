import 'package:spanticom/architectures/domain/entities/FamilyEvaluation.dart';

abstract class FamilyEvaluationHistoryBlocEvent {}

class FamilyEvaluationHistoryBlocStart
    extends FamilyEvaluationHistoryBlocEvent {
  final String firstDate;
  final String lastDate;
  final int childId;
  FamilyEvaluationHistoryBlocStart(
    this.firstDate,
    this.lastDate,
    this.childId,
  );
}
