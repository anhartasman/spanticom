// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserNewAccount {
  final String name;
  final String phone;
  final String email;
  final String password;
  UserNewAccount({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  UserNewAccount copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) {
    return UserNewAccount(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }

  factory UserNewAccount.fromMap(Map<String, dynamic> map) {
    return UserNewAccount(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNewAccount.fromJson(String source) =>
      UserNewAccount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserNewAccount(name: $name, phone: $phone, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant UserNewAccount other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
