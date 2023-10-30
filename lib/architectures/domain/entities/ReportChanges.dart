// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportChanges {
  final String reportId;
  final String statusChange;
  final String noteChange;
  const ReportChanges({
    required this.reportId,
    required this.statusChange,
    required this.noteChange,
  });

  ReportChanges copyWith({
    String? reportId,
    String? statusChange,
    String? noteChange,
  }) {
    return ReportChanges(
      reportId: reportId ?? this.reportId,
      statusChange: statusChange ?? this.statusChange,
      noteChange: noteChange ?? this.noteChange,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reportId': reportId,
      'statusChange': statusChange,
      'noteChange': noteChange,
    };
  }

  factory ReportChanges.fromMap(Map<String, dynamic> map) {
    return ReportChanges(
      reportId: map['reportId'] as String,
      statusChange: map['statusChange'] as String,
      noteChange: map['noteChange'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportChanges.fromJson(String source) =>
      ReportChanges.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportChanges(reportId: $reportId, statusChange: $statusChange, noteChange: $noteChange)';

  @override
  bool operator ==(covariant ReportChanges other) {
    if (identical(this, other)) return true;

    return other.reportId == reportId &&
        other.statusChange == statusChange &&
        other.noteChange == noteChange;
  }

  @override
  int get hashCode =>
      reportId.hashCode ^ statusChange.hashCode ^ noteChange.hashCode;
}
