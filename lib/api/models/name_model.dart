// To parse this JSON data, do
//
//     final name = nameFromJson(jsonString);

import 'dart:convert';

List<Name> nameFromJson(String str) => List<Name>.from(json.decode(str).map((x) => Name.fromJson(x)));

String nameToJson(List<Name> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Name {
  Name({
    required this.name,
  });

  String name;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
