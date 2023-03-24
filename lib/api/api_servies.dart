import 'dart:convert';
import 'dart:io';

import 'package:assets/api/models/assets_model.dart';
import 'package:assets/utils/variables.dart';
import 'package:dio/dio.dart';
import 'models/categary_model.dart';
import 'models/depreciation_model.dart';
import 'models/location_model.dart';
import 'models/owner_model.dart';
import 'models/subcategories1_model.dart';

/// Categary
Future<List<Categary>> getCategories() async {
  var dio = Dio();
  final response = await dio.get(categoryUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Categary.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Subcategories1
Future<List<Subcategory1>> getSubCategory([int? id]) async {
  var dio = Dio();
  final response =
  await dio.get("$subCategoryUrl/$id");
  if (response.statusCode == 200) {
    return (response.data as List)
        .map((e) => Subcategory1.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Location
Future<List<Location>> getLocation() async {
  var dio = Dio();
  final response = await dio.get(locationUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Location.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Description
Future<List<Description>> getDescription() async {
  var dio = Dio();
  final response =
  await dio.get(descriptionUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Description.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Owner
Future<List<Owner>> getOwner() async {
  var dio = Dio();
  final response = await dio.get(ownerUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Owner.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

///post Api
Future postData(
    {String? tag, required String name, required String description,required String amount,
      required String date,required int category,required String subcategory1,required String subcategory2,
      required String location,required String depreciation,required String owner,required List<File> fileImage}) async {
  var dio = Dio();
  Assets? assets;

  // print("fileimage api ==> ${assets!.category}");

  final data =FormData.fromMap({
      "name": name.toString(),
      "description": description.toString(),
      "category": category.toString(),
      "subcategory1": subcategory1.toString(),
      "subcategory2": subcategory2.toString(),
      "acquired": null,
      "acquired_amt": amount,
      "location": location.toString(),
      "status": null,
      "depreciation": depreciation.toString(),
      "owner": owner.toString(),
      "hashref": null,
      "image1": await MultipartFile.fromFile(fileImage[0].path, filename: 'image1.jpg'),
      "image2": await MultipartFile.fromFile(fileImage[1].path, filename: 'image2.jpg'),
      "image3": null,
      "image4": null,
      "invoice": null,
  });
  print('data post ==> ${data}');
  final response = await dio.post(postAssetsUrl,
      data: data);
  print("response ==> ${response.data}");
  if (response.statusCode == 200) {
    // return Assets.fromJson(response.data);
  } else {
    throw Exception('Failed to load album');
  }
}
