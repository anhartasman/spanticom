import 'dart:async';

import 'package:spanticom/architectures/domain/entities/UserAccount.dart';
import 'package:spanticom/architectures/domain/entities/UserAuth.dart';
import 'package:spanticom/architectures/domain/repositories/AuthRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class UserLoginUseCase extends UseCase<UserAccount, UserAuth> {
  UserLoginUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Stream<UserAccount>> call(UserAuth theAuth) async {
    final StreamController<UserAccount> controller = StreamController();

    try {
      final the_respon = await repository.authenticate(theAuth);

      controller.add((the_respon));

      controller.close();
    } catch (e) {
      print("add error ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    }

    return controller.stream;
  }
}
