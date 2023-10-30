import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';

abstract class UserReportListBlocState extends Equatable {
  final List<UserReport> reportList;
  const UserReportListBlocState({this.reportList = const []});
  @override
  List<Object> get props => [reportList];
}

class UserReportListBlocStateOnIdle extends UserReportListBlocState {
  const UserReportListBlocStateOnIdle();
}

class UserReportListBlocStateOnStarted extends UserReportListBlocState {}

class UserReportListBlocStateOnSuccess extends UserReportListBlocState {
  final List<UserReport> reportList;
  const UserReportListBlocStateOnSuccess(this.reportList)
      : super(reportList: reportList);
}

class UserReportListBlocStateOnError extends UserReportListBlocState {
  final String errorMessage;
  UserReportListBlocStateOnError(this.errorMessage);
}
