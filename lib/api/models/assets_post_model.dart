// To parse this JSON data, do
//
//     final assets = assetsFromJson(jsonString);

import 'dart:convert';

AssetsPost assetsFromJson(String str) => AssetsPost.fromJson(json.decode(str));

String assetsToJson(AssetsPost data) => json.encode(data.toJson());

class AssetsPost {
  AssetsPost({
    this.name,
    this.description,
    this.category,
    this.subcategory1,
    this.subcategory2,
    this.acquired,
    this.acquiredAmt,
    this.location,
    this.status,
    this.depreciation,
    this.owner,
    this.hashref,
    this.tag,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.invoice,
  });

  String? name;
  dynamic description;
  String? category;
  String? subcategory1;
  String? subcategory2;
  dynamic acquired;
  dynamic acquiredAmt;
  String? location;
  dynamic status;
  String? depreciation;
  String? owner;
  dynamic hashref;
  String? tag;
  dynamic image1;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  dynamic invoice;

  factory AssetsPost.fromJson(Map<String, dynamic> json) => AssetsPost(
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
    tag: json["tag"],
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
    "tag": tag,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "invoice": invoice,
  };
}
