import 'dart:async';

import 'package:spanticom/architectures/domain/entities/UserNewAccount.dart';
import 'package:spanticom/architectures/domain/repositories/AuthRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class UserRegisterUseCase extends UseCase<void, UserNewAccount> {
  UserRegisterUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Stream<void>> call(UserNewAccount newAccount) async {
    final StreamController<void> controller = StreamController();

    try {
      final the_respon = await repository.register(newAccount);

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
