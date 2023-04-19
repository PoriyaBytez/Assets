// To parse this JSON data, do
//
//     final assetsGet = assetsGetFromJson(jsonString);

import 'dart:convert';

AssetsGet assetsGetFromJson(String str) => AssetsGet.fromJson(json.decode(str));

String assetsGetToJson(AssetsGet data) => json.encode(data.toJson());

class AssetsGet {
  AssetsGet({
    required this.id,
    // required this.scanned,
    this.tag,
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
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.invoice,
    required this.deleted,
  });

  String id;
  // DateTime scanned;
  dynamic tag;
  dynamic name;
  dynamic description;
  dynamic category;
  dynamic subcategory1;
  dynamic subcategory2;
  dynamic acquired;
  dynamic acquiredAmt;
  dynamic location;
  dynamic status;
  dynamic depreciation;
  dynamic owner;
  dynamic hashref;
  dynamic image1;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  dynamic invoice;
  String deleted;

  factory AssetsGet.fromJson(Map<String, dynamic> json) => AssetsGet(
    id: json["id"],
    // scanned: DateTime.parse(json["scanned"]),
    tag: json["tag"],
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
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    // "scanned": scanned.toIso8601String(),
    "tag": tag,
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
    "deleted": deleted,
  };
}
