import 'dart:async';

import 'package:spanticom/architectures/domain/entities/FamilyMember.dart';
import 'package:spanticom/architectures/domain/repositories/FamilyRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class FamilyMemberDetailUseCase extends UseCase<FamilyMember, int> {
  FamilyMemberDetailUseCase(this.repository);

  final FamilyRepository repository;

  @override
  Future<Stream<FamilyMember>> call(
    int id,
  ) async {
    final StreamController<FamilyMember> controller = StreamController();

    repository.memberDetail(id).then((the_respon) {
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
