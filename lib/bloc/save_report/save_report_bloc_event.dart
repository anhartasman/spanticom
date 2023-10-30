import 'package:spanticom/architectures/domain/entities/UserReport.dart';

abstract class SaveReportBlocEvent {}

class SaveReportBlocStart extends SaveReportBlocEvent {
  final UserReport theReport;
  SaveReportBlocStart(this.theReport);
}
