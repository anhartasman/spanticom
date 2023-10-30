import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class SaveReportBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveReportBlocStateOnIdle extends SaveReportBlocState {}

class SaveReportBlocStateOnStarted extends SaveReportBlocState {}

class SaveReportBlocStateOnSuccess extends SaveReportBlocState {}

class SaveReportBlocStateOnError extends SaveReportBlocState {
  final String errorMessage;
  SaveReportBlocStateOnError({
    required this.errorMessage,
  });
}
