
import '../api/models/category_model.dart';
import '../api/models/depreciation_model.dart';
import '../api/models/location_model.dart';
import '../api/models/owner_model.dart';
import '../api/servies/api_servies.dart';

List<Location> locationList = [];
List<Owner> ownerList = [];
List<Categary> categoryList = [];
List<Depreciation> depreciationList = [];

getCategoriesList() async {
  categoryList = await getCategories();
}

getLocationCategory() async {
  locationList = await getLocation();
}

getOwnerCategory() async {
  ownerList = await getOwner();
}

getDepreciationCategory() async {
  depreciationList = await getDepreciation();
}