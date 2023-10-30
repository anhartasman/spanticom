import 'package:spanticom/architectures/domain/entities/FamilyEvaluation.dart';

abstract class FamilyEvaluationSaveBlocEvent {}

class FamilyEvaluationSaveBlocStart extends FamilyEvaluationSaveBlocEvent {
  final FamilyEvaluation theEvaluation;
  FamilyEvaluationSaveBlocStart(this.theEvaluation);
}
