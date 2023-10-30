import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:spanticom/architectures/domain/entities/MemberInfo.dart';

abstract class MemberInfoBlocState extends Equatable {
  const MemberInfoBlocState();
  @override
  List<Object> get props => [];
}

class MemberInfoBlocStateOnIdle extends MemberInfoBlocState {
  const MemberInfoBlocStateOnIdle();
}

class MemberInfoBlocStateOnStarted extends MemberInfoBlocState {}

class MemberInfoBlocStateOnSuccess extends MemberInfoBlocState {
  final MemberInfo memberInfo;
  const MemberInfoBlocStateOnSuccess(this.memberInfo);
}

class MemberInfoBlocStateOnError extends MemberInfoBlocState {
  final String errorMessage;
  MemberInfoBlocStateOnError(this.errorMessage);
}
