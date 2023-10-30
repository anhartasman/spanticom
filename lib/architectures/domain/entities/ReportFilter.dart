// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportFilter {
  final String status;
  const ReportFilter({
    required this.status,
  });

  ReportFilter copyWith({
    String? status,
  }) {
    return ReportFilter(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory ReportFilter.fromMap(Map<String, dynamic> map) {
    return ReportFilter(
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportFilter.fromJson(String source) =>
      ReportFilter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReportFilter(status: $status)';

  @override
  bool operator ==(covariant ReportFilter other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
