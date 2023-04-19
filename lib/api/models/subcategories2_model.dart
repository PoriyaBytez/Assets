// // To parse this JSON data, do
// //
// //     final subcategory2 = subcategory2FromJson(jsonString);
//
// import 'dart:convert';
//
// Subcategory2 subcategory2FromJson(String str) => Subcategory2.fromJson(json.decode(str));
//
// String subcategory2ToJson(Subcategory2 data) => json.encode(data.toJson());
//
// class Subcategory2 {
//   Subcategory2({
//     required this.id,
//     required this.name,
//     this.description,
//     required this.subcategory1,
//     required this.company,
//     required this.deleted,
//   });
//
//   String id;
//   String name;
//   String? description;
//   String subcategory1;
//   String company;
//   String deleted;
//
//   factory Subcategory2.fromJson(Map<String, dynamic> json) => Subcategory2(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     subcategory1: json["subcategory1"],
//     company: json["company"],
//     deleted: json["deleted"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "subcategory1": subcategory1,
//     "company": company,
//     "deleted": deleted,
//   };
// }
