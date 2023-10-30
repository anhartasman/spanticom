import 'dart:async';

import 'package:spanticom/architectures/domain/entities/ReportFilter.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/architectures/domain/repositories/ReportRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class UserReportListUseCase extends UseCase<List<UserReport>, ReportFilter> {
  UserReportListUseCase(this.repository);

  final ReportRepository repository;

  @override
  Future<Stream<List<UserReport>>> call(
    ReportFilter theFilter,
  ) async {
    final StreamController<List<UserReport>> controller = StreamController();

    repository.reportList(theFilter).then((the_respon) {
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
