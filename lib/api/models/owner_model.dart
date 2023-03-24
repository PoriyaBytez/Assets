// To parse this JSON data, do
//
//     final owner = ownerFromJson(jsonString);

import 'dart:convert';

List<Owner> ownerFromJson(String str) => List<Owner>.from(json.decode(str).map((x) => Owner.fromJson(x)));

String ownerToJson(List<Owner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Owner {
  Owner({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.company,
    required this.deleted,
  });

  String id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String company;
  String deleted;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    company: json["company"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "company": company,
    "deleted": deleted,
  };
}
