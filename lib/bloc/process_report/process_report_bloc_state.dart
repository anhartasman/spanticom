import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class ProcessReportBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProcessReportBlocStateOnIdle extends ProcessReportBlocState {}

class ProcessReportBlocStateOnStarted extends ProcessReportBlocState {}

class ProcessReportBlocStateOnSuccess extends ProcessReportBlocState {}

class ProcessReportBlocStateOnError extends ProcessReportBlocState {
  final String errorMessage;
  ProcessReportBlocStateOnError({
    required this.errorMessage,
  });
}
