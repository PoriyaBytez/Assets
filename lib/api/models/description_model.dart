// To parse this JSON data, do
//
//     final description = descriptionFromJson(jsonString);

import 'dart:convert';

List<Description> descriptionFromJson(String str) => List<Description>.from(json.decode(str).map((x) => Description.fromJson(x)));

String descriptionToJson(List<Description> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Description {
  Description({
    this.description,
  });

  String? description;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
  };
}
