import 'dart:async';

import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/architectures/domain/repositories/ReportRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class SaveReportUseCase extends UseCase<void, UserReport> {
  SaveReportUseCase(this.repository);

  final ReportRepository repository;

  @override
  Future<Stream<void>> call(UserReport theReport) async {
    final StreamController<void> controller = StreamController();

    try {
      final the_respon = await repository.saveReport(theReport);

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
