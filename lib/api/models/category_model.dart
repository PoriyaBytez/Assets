// To parse this JSON data, do
//
//     final categary = categaryFromJson(jsonString);

import 'dart:convert';

List<Categary> categaryFromJson(String str) => List<Categary>.from(json.decode(str).map((x) => Categary.fromJson(x)));

String categaryToJson(List<Categary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categary {
  Categary({
    required this.id,
    required this.name,
    this.description,
    required this.company,
    required this.subcategories,
  });

  int id;
  String name;
  String? description;
  int company;
  List<Subcategory> subcategories;

  factory Categary.fromJson(Map<String, dynamic> json) => Categary(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    company: json["company"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "company": company,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
