import 'dart:async';

import 'package:spanticom/architectures/domain/entities/ReportChanges.dart';
import 'package:spanticom/architectures/domain/repositories/ReportRepository.dart';
import 'package:spanticom/architectures/usecase/usecase.dart';

class ProcessReportUseCase extends UseCase<void, ReportChanges> {
  ProcessReportUseCase(this.repository);

  final ReportRepository repository;

  @override
  Future<Stream<void>> call(ReportChanges reportChange) async {
    final StreamController<void> controller = StreamController();

    try {
      final the_respon = await repository.processReport(reportChange);

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
