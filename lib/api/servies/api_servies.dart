import 'package:assets/api/models/assets_post_model.dart';
import 'package:assets/api/models/name_model.dart';
import 'package:assets/api/models/subcategories1_model.dart';
import 'package:dio/dio.dart';
import '../models/asset_get_model.dart';
import '../models/category_model.dart';
import '../models/depreciation_model.dart';
import '../models/description_model.dart';
import '../models/location_model.dart';
import '../models/owner_model.dart';
import 'api_path.dart';


var dio = Dio();

/// Name
Future<List<Name>> getName() async {
  final response = await dio.get(nameUrl);
  if (response.statusCode == 200) {
    // print("name data ==> ${response.data}");
    return (response.data as List).map((e) => Name.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Description
Future<List<Description>> getDescription() async {
  final response = await dio.get(descriptionUrl);
  if (response.statusCode == 200) {
    // print("descriptionUrl data ==> ${response.data}");
    return (response.data as List).map((e) => Description.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Category & Subcategories 1
Future<List<Categary>> getCategories() async {
  final response = await dio.get(categoryUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Categary.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Subcategories 2
Future<List<Subcategory1>> getSubCategory([String? id]) async {
  final response = await dio.get("$subCategoryUrl/$id");
  if (response.statusCode == 200) {
    // return Subcategory1.fromJson(response.data);
    return (response.data as List)
        .map((e) => Subcategory1.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Location
Future<List<Location>> getLocation() async {
  final response = await dio.get(locationUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Location.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Description
Future<List<Depreciation>> getDepreciation() async {
  final response = await dio.get(depreciationUrl);
  if (response.statusCode == 200) {
    return (response.data as List)
        .map((e) => Depreciation.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

/// Owner
Future<List<Owner>> getOwner() async {
  final response = await dio.get(ownerUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Owner.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

///post Api
Future postData({required AssetsPost assets}
    /*{required String tag,
    required String name,
    String? description,
    int? category,
    String? subcategory1,
    String? subcategory2,
    String? location,
    String? depreciation,
    required String owner,
    String? amount,
    String? date,
    List<File>? fileImage}*/) async {

  final data = FormData.fromMap(
    assets.toJson()
   /*   {
    "tag": tag.toString(),
    "name": name.toString(),
    "description": description?.toString(),
    "category": category?.toString(),
    "subcategory1": subcategory1?.toString(),
    "subcategory2": subcategory2?.toString(),
    "acquired": null,
    "acquired_amt": amount?.toString(),
    "location": location?.toString(),
    "status": null,
    "depreciation": depreciation?.toString(),
    "owner": owner.toString(),
    "hashref": null,
    "image1": fileImage!.length > 0
        ? await MultipartFile.fromFile(fileImage[0].path,
            filename: 'image3.jpg')
        : null,
    "image2": fileImage.length > 1
        ? await MultipartFile.fromFile(fileImage[1].path,
            filename: 'image3.jpg')
        : null,
    "image3": fileImage.length > 2
        ? await MultipartFile.fromFile(fileImage[2].path,
            filename: 'image3.jpg')
        : null,
    "image4": fileImage.length > 3
        ? await MultipartFile.fromFile(fileImage[3].path,
            filename: 'image4.jpg')
        : null,
    "invoice": null,
  }*/
  );
  print('data post ==> ${data.fields}');
  try {
    final response = await dio.post(postAssetsUrl, data: data);
    print("response ==> ${response.statusCode}");
    return true;
  } on DioError catch (e) {
    return false;
  }
}

Future loginDetailUpload ({required String email,required String pass}) async {

  final data = FormData.fromMap({
    "username": email,
    "password": pass,
  });

  try {
    final response = await dio.post(loginUrl, data: data);
    print("response ==> ${response.statusCode}");
    return true;
  } on DioError catch (e) {
    return false;
  }
}

Future<List<AssetsGet>> getAllDataFromAssets() async {
  final response = await dio.get(allAssetsUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => AssetsGet.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

