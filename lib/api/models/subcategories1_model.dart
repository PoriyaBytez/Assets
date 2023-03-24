// To parse this JSON data, do
//
//     final subcategory1 = subcategory1FromJson(jsonString);

import 'dart:convert';

List<Subcategory1> subcategory1FromJson(String str) => List<Subcategory1>.from(json.decode(str).map((x) => Subcategory1.fromJson(x)));

String subcategory1ToJson(List<Subcategory1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcategory1 {
  Subcategory1({
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
  List<Subcategory_1> subcategories;

  factory Subcategory1.fromJson(Map<String, dynamic> json) => Subcategory1(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    company: json["company"],
    subcategories: List<Subcategory_1>.from(json["subcategories"].map((x) => Subcategory_1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "company": company,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}

class Subcategory_1 {
  Subcategory_1({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Subcategory_1.fromJson(Map<String, dynamic> json) => Subcategory_1(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
