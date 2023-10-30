import 'package:logging/logging.dart';
import 'package:spanticom/architectures/data/datasources/remote/report_remote_data_source.dart';
import 'package:spanticom/architectures/domain/entities/ReportChanges.dart';
import 'package:spanticom/architectures/domain/entities/ReportFilter.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/architectures/domain/repositories/ReportRepository.dart';

class DataReportRepository implements ReportRepository {
  late Logger _logger;

  DataReportRepository() {
    _logger = Logger('DataReportRepository');
  }

  @override
  Future<List<UserReport>> reportList(ReportFilter theFilter) async {
    final reportList = await ReportRemoteDataSource.reportList(theFilter);
    return reportList;
  }

  @override
  Future<void> saveReport(UserReport theReport) async {
    await ReportRemoteDataSource.saveReport(theReport);
  }

  @override
  Future<void> processReport(ReportChanges reportChange) async {
    await ReportRemoteDataSource.processReport(reportChange);
  }
}
