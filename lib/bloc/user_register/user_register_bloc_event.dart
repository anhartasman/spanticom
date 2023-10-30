import 'package:spanticom/architectures/domain/entities/UserNewAccount.dart';

abstract class UserRegisterBlocEvent {}

class UserRegisterBlocStart extends UserRegisterBlocEvent {
  final UserNewAccount newAccount;
  UserRegisterBlocStart(this.newAccount);
}
