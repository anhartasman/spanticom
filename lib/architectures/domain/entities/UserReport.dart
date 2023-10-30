// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReport {
  final String id;
  final String userId;
  final DateTime dateTime;
  final String name;
  final String doneNote;
  final String email;
  final String phone;
  final String className;
  final String report;
  final String status;
  const UserReport({
    required this.id,
    required this.userId,
    required this.dateTime,
    required this.name,
    required this.doneNote,
    required this.email,
    required this.phone,
    required this.className,
    required this.report,
    required this.status,
  });

  UserReport copyWith({
    String? id,
    String? userId,
    DateTime? dateTime,
    String? name,
    String? doneNote,
    String? email,
    String? phone,
    String? className,
    String? report,
    String? status,
  }) {
    return UserReport(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      doneNote: doneNote ?? this.doneNote,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      className: className ?? this.className,
      report: report ?? this.report,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'name': name,
      'doneNote': doneNote,
      'email': email,
      'phone': phone,
      'className': className,
      'report': report,
      'status': status,
    };
  }

  factory UserReport.fromMap(Map<String, dynamic> map) {
    return UserReport(
      id: map['id'] as String,
      userId: map['userId'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      name: map['name'] as String,
      doneNote: map['doneNote'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      className: map['className'] as String,
      report: map['report'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReport.fromJson(String source) =>
      UserReport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserReport(id: $id, userId: $userId, dateTime: $dateTime, name: $name, doneNote: $doneNote, email: $email, phone: $phone, className: $className, report: $report, status: $status)';
  }

  @override
  bool operator ==(covariant UserReport other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.dateTime == dateTime &&
        other.name == name &&
        other.doneNote == doneNote &&
        other.email == email &&
        other.phone == phone &&
        other.className == className &&
        other.report == report &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        dateTime.hashCode ^
        name.hashCode ^
        doneNote.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        className.hashCode ^
        report.hashCode ^
        status.hashCode;
  }
}
