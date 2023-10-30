import 'dart:async';

import 'package:spanticom/architectures/domain/entities/MemberInfo.dart';
import 'package:spanticom/architectures/domain/repositories/MemberRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class MemberInfoUseCase extends UseCase<MemberInfo, String> {
  MemberInfoUseCase(this.repository);

  final MemberRepository repository;

  @override
  Future<Stream<MemberInfo>> call(
    String memberId,
  ) async {
    final StreamController<MemberInfo> controller = StreamController();

    repository.memberInfo(memberId).then((the_respon) {
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
