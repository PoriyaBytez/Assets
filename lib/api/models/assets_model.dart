// To parse this JSON data, do
//
//     final assets = assetsFromJson(jsonString);

import 'dart:convert';

Assets assetsFromJson(String str) => Assets.fromJson(json.decode(str));

String assetsToJson(Assets data) => json.encode(data.toJson());

class Assets {
  Assets({
    required this.name,
    this.description,
    required this.category,
    required this.subcategory1,
    required this.subcategory2,
    this.acquired,
    this.acquiredAmt,
    required this.location,
    this.status,
    required this.depreciation,
    required this.owner,
    this.hashref,
    required this.image1,
    required this.image2,
    this.image3,
    this.image4,
    this.invoice,
  });

  String name;
  dynamic description;
  String category;
  String subcategory1;
  String subcategory2;
  dynamic acquired;
  dynamic acquiredAmt;
  String location;
  dynamic status;
  String depreciation;
  String owner;
  dynamic hashref;
  String image1;
  String image2;
  dynamic image3;
  dynamic image4;
  dynamic invoice;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
    name: json["name"],
    description: json["description"],
    category: json["category"],
    subcategory1: json["subcategory1"],
    subcategory2: json["subcategory2"],
    acquired: json["acquired"],
    acquiredAmt: json["acquired_amt"],
    location: json["location"],
    status: json["status"],
    depreciation: json["depreciation"],
    owner: json["owner"],
    hashref: json["hashref"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    invoice: json["invoice"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "category": category,
    "subcategory1": subcategory1,
    "subcategory2": subcategory2,
    "acquired": acquired,
    "acquired_amt": acquiredAmt,
    "location": location,
    "status": status,
    "depreciation": depreciation,
    "owner": owner,
    "hashref": hashref,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "invoice": invoice,
  };
}
