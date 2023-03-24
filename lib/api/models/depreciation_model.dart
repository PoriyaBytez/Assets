// To parse this JSON data, do
//
//     final description = descriptionFromJson(jsonString);

import 'dart:convert';

List<Description> descriptionFromJson(String str) => List<Description>.from(json.decode(str).map((x) => Description.fromJson(x)));

String descriptionToJson(List<Description> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Description {
  Description({
    required this.id,
    required this.name,
    required this.description,
    this.periodMonths,
    required this.percentagePa,
    required this.company,
    required this.deleted,
  });

  String id;
  String name;
  String description;
  String? periodMonths;
  String percentagePa;
  String company;
  String deleted;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    periodMonths: json["period_months"],
    percentagePa: json["percentage_pa"],
    company: json["company"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "period_months": periodMonths,
    "percentage_pa": percentagePa,
    "company": company,
    "deleted": deleted,
  };
}
