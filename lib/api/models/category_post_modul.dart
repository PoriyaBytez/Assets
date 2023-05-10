// To parse this JSON data, do
//
//     final categoryPost = categoryPostFromJson(jsonString);

import 'dart:convert';

CategoryPost categoryPostFromJson(String str) => CategoryPost.fromJson(json.decode(str));

String categoryPostToJson(CategoryPost data) => json.encode(data.toJson());

class CategoryPost {
  String name;
  String description;
  String? company;

  CategoryPost({
    required this.name,
    required this.description,
     this.company,
  });

  factory CategoryPost.fromJson(Map<String, dynamic> json) => CategoryPost(
    name: json["name"],
    description: json["description"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "company": company,
  };
}
