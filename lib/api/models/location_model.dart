import 'dart:convert';

List<Location> locationFromJson(String str) => List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location({
    required this.id,
    this.tag,
    required this.name,
    required this.description,
    required this.address,
    required this.company,
    required this.deleted,
  });

  String id;
  String? tag;
  String name;
  String description;
  String address;
  String company;
  String deleted;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    tag: json["tag"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    company: json["company"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "name": name,
    "description": description,
    "address": address,
    "company": company,
    "deleted": deleted,
  };
}
