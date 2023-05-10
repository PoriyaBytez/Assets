import 'package:assets/utils/const_colors.dart';
import 'package:assets/utils/static_function.dart';
import 'package:flutter/material.dart';

TextStyle? commonTextStyle = const TextStyle(fontSize: 14);
TextStyle? commonHintStyle = TextStyle(fontSize: 18,color: textCommonColor);
TextStyle? commonSelectedStyle = const TextStyle(fontSize: 18);

BoxBorder? commonBorder = Border.all(width: 1,color: commonBorderColor);


/// filter screen bool variable for select
List<bool> selectedCategory = List.filled(categoryList.length, false);
/*List.generate(categoryList.length, (index) => false);*/
List<bool> selectedLocation = List.filled(locationList.length, false);
List<bool> selectedOwner = List.filled(ownerList.length, false);
List<bool> selectedDepreciation = List.filled(depreciationList.length,false);
List<bool> selectedFilter = List.filled(filterAssets.length, false);

/// filter screen For store selected item id
List<Map<String, String>> selectLocationItemId = [];
List<Map<String, String>> selectOwnerItemId = [];
List<Map<String, String>> selectDepreciationItemId = [];

/// for asset screen to filter data
List filterValueCategory = [];
List filterValueLocation = [];
List filterValueOwner = [];
List filterValueDepreciation = [];


List filterAssets = [
  "Category",
  "Location",
  "Owner",
  "Depreciation",
];



