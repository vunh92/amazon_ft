import 'dart:convert';

class SignUpRequest {
  String name;
  String email;
  String password;

  SignUpRequest(this.name, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  String toJson() => jsonEncode(toMap());
}