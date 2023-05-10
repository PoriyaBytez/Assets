import 'package:assets/api/models/assets_post_model.dart';
import 'package:assets/api/models/category_post_modul.dart';
import 'package:assets/api/models/name_model.dart';
import 'package:assets/api/models/serviece_post_modul.dart';
import 'package:assets/api/models/subcategories1_model.dart';
import 'package:dio/dio.dart';
import '../models/asset_get_model.dart';
import '../models/category_model.dart';
import '../models/depreciation_model.dart';
import '../models/description_model.dart';
import '../models/location_model.dart';
import '../models/owner_model.dart';
import '../models/service_get_modul.dart';
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

/// all data get
Future<List<AssetsGet>> getAllDataFromAssets() async {
  final response = await dio.get(allAssetsUrl);
  if (response.statusCode == 200) {
    return (response.data as List).map((e) => AssetsGet.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

// ================================================== post Api ===================================================

/// New asset post
Future postData({required AssetsPost assets}) async {

  final data = FormData.fromMap(
    assets.toJson()
  );
  print('data post ==> ${data.fields}');
  try {
    final response = await dio.post(postAssetsUrl, data: data);
    print("response ==> ${response.statusCode}");
    return true;
  } on DioError catch (e) {
    print("error ==> $e");
    return false;
  }
}

/// login data post
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

/// New category post
  Future createNewCategory (CategoryPost dataPost) async {

    final data = FormData.fromMap(
        dataPost.toJson()
    );
    try {
      final response = await dio.post(loginUrl, data: data);
      print("response ==> ${response.statusCode}");
      print("response ==> ${response.data}");
      return true;
    } on DioError catch (e) {
      return false;
    }
}

///service data post
  Future serviceReminderPost(ServiceGet dataPost) async {
     final data = {
       "asset": dataPost.asset,
       "tag": dataPost.tag,
       "comment_out": dataPost.commentOut,
       "date_out": dataPost.dateOut
     };

     try {
       print("object dataPost ==> ${data}");
       final response = await dio.post(serviceReminderUrl, data: data);
       print("response ==> ${response.statusCode}");
       print("response ==> ${response.data}");
       return true;
     } on DioError catch (e) {
       print("error ==> $e");
       return false;
     }
}

