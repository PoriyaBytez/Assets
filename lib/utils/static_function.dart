
import '../api/models/category_model.dart';
import '../api/models/depreciation_model.dart';
import '../api/models/location_model.dart';
import '../api/models/owner_model.dart';
import '../api/models/subcategories1_model.dart';
import '../api/servies/api_servies.dart';

List<Location> locationList = [];
List<Owner> ownerList = [];
List<Categary> categoryList = [];
List<Depreciation> depreciationList = [];
List<Subcategory_1> subCategoryList2 = [];
List<Subcategory> subCategoryList1 = [];

/// for show
String categoryItem = '';
String subCategoryItem1 = '';
String subCategoryItem2 = '';
String depreciationItem = '';
String locationItem = '';
String ownerItem = '';
String tag = '';


getCategoriesList() async {
  categoryList = await getCategories();
}

getLocationCategory() async {
  locationList = await getLocation();
}

getOwnerCategory() async {
  ownerList = await getOwner();
}
getSubCategories1([String? id]) async {
  List<Subcategory1> tempSubcategoryList1 = await getSubCategory(id);
  subCategoryList2 = tempSubcategoryList1[0].subcategories;
  // setState(() {});
}

getDepreciationCategory() async {
  depreciationList = await getDepreciation();
}