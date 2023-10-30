import 'dart:convert';

import 'UserProfile.dart';

/// A user of the application.
class UserAccount {
  final String id;

  final String email;

  final String phone;

  final String password;

  final UserProfile profil;

  const UserAccount({
    this.id = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.profil = const UserProfile(),
  });

  UserAccount copyWith({
    String? id,
    String? email,
    String? phone,
    String? password,
    UserProfile? profil,
  }) {
    return UserAccount(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      profil: profil ?? this.profil,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'password': password});
    result.addAll({'profil': profil.toMap()});

    return result;
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      profil: UserProfile.fromMap(map['profil']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) =>
      UserAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAccount(id: $id, email: $email, phone: $phone, password: $password, profil: $profil)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAccount &&
        other.id == id &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.profil == profil;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        profil.hashCode;
  }
}
