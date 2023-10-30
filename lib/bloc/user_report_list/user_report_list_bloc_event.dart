import 'package:spanticom/architectures/domain/entities/ReportFilter.dart';

abstract class UserReportListBlocEvent {}

class UserReportListBlocRetrieve extends UserReportListBlocEvent {
  final ReportFilter theFilter;
  UserReportListBlocRetrieve(this.theFilter);
}
