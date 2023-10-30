import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:spanticom/architectures/domain/entities/UserAccount.dart';

abstract class UserRegisterBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserRegisterOnIdle extends UserRegisterBlocState {}

class UserRegisterOnStarted extends UserRegisterBlocState {}

class UserRegisterOnSuccess extends UserRegisterBlocState {}

class UserRegisterOnError extends UserRegisterBlocState {
  final String errorMessage;
  UserRegisterOnError({
    required this.errorMessage,
  });
}
