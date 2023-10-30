import 'package:spanticom/architectures/domain/entities/UserAccount.dart';
import 'package:spanticom/architectures/domain/entities/UserAuth.dart';
import 'package:spanticom/architectures/domain/entities/UserNewAccount.dart';

abstract class AuthRepository {
  Future<UserAccount> authenticate(UserAuth userAuth);
  Future<void> register(UserNewAccount newAccount);
}
