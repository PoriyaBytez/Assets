// To parse this JSON data, do
//
//     final currentUser = currentUserFromJson(jsonString);

import 'dart:convert';

CurrentUser currentUserFromJson(String str) => CurrentUser.fromJson(json.decode(str));

String currentUserToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  CurrentUser({
    required this.firstname,
    required this.lastname,
    required this.company,
    required this.role,
    required this.email,
    required this.id,
  });

  String firstname;
  String lastname;
  String company;
  String role;
  String email;
  String id;

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
    firstname: json["firstname"],
    lastname: json["lastname"],
    company: json["company"],
    role: json["role"],
    email: json["email"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "company": company,
    "role": role,
    "email": email,
    "id": id,
  };
}
