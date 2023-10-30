import 'dart:async';

import 'package:spanticom/architectures/domain/entities/FamilyMember.dart';
import 'package:spanticom/architectures/domain/repositories/FamilyRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class FamilyMemberListUseCase extends UseCase<List<FamilyMember>, NoParams> {
  FamilyMemberListUseCase(this.repository);

  final FamilyRepository repository;

  @override
  Future<Stream<List<FamilyMember>>> call(
    NoParams params,
  ) async {
    final StreamController<List<FamilyMember>> controller = StreamController();

    repository.memberList().then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}
