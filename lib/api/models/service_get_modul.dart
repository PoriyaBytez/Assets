// To parse this JSON data, do
//
//     final serviceGet = serviceGetFromJson(jsonString);

import 'dart:convert';

List<ServiceGet> serviceGetFromJson(String str) => List<ServiceGet>.from(json.decode(str).map((x) => ServiceGet.fromJson(x)));

String serviceGetToJson(List<ServiceGet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceGet {
  ServiceGet({
    this.asset,
    this.tag,
    this.commentIn,
    this.dateOut,
    this.cost,
    this.deleted,
    this.dateIn,
    this.commentOut,
    this.id,
  });

  String? asset;
  String? tag;
  String? commentIn;
  String? dateOut;
  dynamic cost;
  String? deleted;
  String? dateIn;
  String? commentOut;
  String? id;


  factory ServiceGet.fromJson(Map<String, dynamic> json) => ServiceGet(
    asset: json["asset"],
    tag: json["tag"],
    commentIn: json["comment_in"],
    dateOut: json["date_out"],
    cost: json["cost"],
    deleted: json["deleted"],
    dateIn: json["date_in"],
    commentOut: json["comment_out"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "asset": asset,
    "tag": tag,
    "comment_in": commentIn,
    "date_out": dateOut,
    "cost": cost,
    "deleted": deleted,
    "date_in": dateIn,
    "comment_out": commentOut,
    "id": id,
  };
}
