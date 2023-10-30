// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MemberInfo {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  MemberInfo({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  MemberInfo copyWith({
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhone,
  }) {
    return MemberInfo(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
    };
  }

  factory MemberInfo.fromMap(Map<String, dynamic> map) {
    return MemberInfo(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userEmail: map['userEmail'] as String,
      userPhone: map['userPhone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberInfo.fromJson(String source) =>
      MemberInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MemberInfo(userId: $userId, userName: $userName, userEmail: $userEmail, userPhone: $userPhone)';
  }

  @override
  bool operator ==(covariant MemberInfo other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userPhone == userPhone;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userPhone.hashCode;
  }
}
