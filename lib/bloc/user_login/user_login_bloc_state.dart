import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:spanticom/architectures/domain/entities/UserAccount.dart';

abstract class UserLoginBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoginOnIdle extends UserLoginBlocState {}

class UserLoginOnStarted extends UserLoginBlocState {}

class UserLoginOnSuccess extends UserLoginBlocState {
  final UserAccount theAccount;
  UserLoginOnSuccess({
    required this.theAccount,
  });
}

class UserLoginOnError extends UserLoginBlocState {
  final String errorMessage;
  UserLoginOnError({
    required this.errorMessage,
  });
}
