import 'dart:io';

import 'package:assets/api/models/name_model.dart';
import 'package:assets/screens/qr_scanner.dart';
import 'package:assets/utils/variables.dart';
import 'package:assets/widgets/customContainer.dart';
import 'package:assets/widgets/dropdown_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../api/models/asset_get_model.dart';
import '../api/models/assets_post_model.dart';
import '../api/servies/api_servies.dart';
import '../api/models/description_model.dart';
import '../utils/const_colors.dart';
import '../utils/static_function.dart';
import '../widgets/Common_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../widgets/custom_dropdown_container.dart';
import '../widgets/dialogs.dart';

class AssetEditing extends StatefulWidget {
  AssetEditing({this.assets});

  AssetsGet? assets;

  @override
  State<AssetEditing> createState() => _AssetEditingState();
}

class _AssetEditingState extends State<AssetEditing> {
  ///image selection
  int pageIndex = 0;
  List<File>? fileImage = [];
  List imagePath = [];
  final PageController pageController =
  PageController(initialPage: 0, keepPage: false);

  /// list for show value in drop down
  List<Name> nameList = [];
  List<Name> searchNameList = [];
  List<Description> descriptionList = [];
  List<Description> searchDescriptionList = [];
  List<dynamic> searchAllList = [];

  /// bool for open close drop down
  bool boolListCategory = true;
  bool boolListSubCategory1 = true;
  bool boolListSubCategory2 = true;
  bool boolListLocation = true;
  bool boolListStatus = true;
  bool boolListDepreciation = true;
  bool boolListOwner = true;
  bool? boolUploadingData;

  bool categoryNotFound = false;

  /// for get id
  String? categoryId;
  String? subCategory1Id;
  String? subCategory2Id;
  String? depreciationId;
  String? locationId;
  String? ownerId;
  String acquiredDate = '';


  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController searchSubCategory1Controller = TextEditingController();
  TextEditingController searchSubCategory2Controller = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();
  TextEditingController searchStatusController = TextEditingController();
  TextEditingController searchDepreciationController = TextEditingController();
  TextEditingController searchOwnerController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController? amountController;

  getNameList() async {
    nameList = await getName();
    setState(() {});
  }

  getDescriptionList() async {
    descriptionList = await getDescription();
    setState(() {});
  }

  AssetsGet? get edit => widget.assets;
  List<String>? editImage = [];

  /// When try to edit the data
  saveEditValue() {
    if (edit != null) {
      if (edit!.category != "") {
        for (int i = 0; i < categoryList.length; i++) {
          if (edit!.category.toString() == categoryList[i].id.toString()) {
            categoryItem = categoryList[i].name;
            subCategoryList1 = categoryList[i].subcategories;
            print("categoryList[i].name ==> ${categoryList[i].name}");
            break;
          }
        }
      } else {
        categoryItem = "";
      }

      if (edit!.subcategory1 != "") {
        getSubCategories1(edit!.subcategory1.toString());
        for (int i = 0; i < subCategoryList1.length; i++) {
          if (edit!.subcategory1.toString() ==
              subCategoryList1[i].id.toString()) {
            subCategoryItem1 = subCategoryList1[i].name;
            break;
          }
        }
      } else {
        subCategoryItem1 = "";
      }

      if (edit!.subcategory2 != "") {
        print("nameList == ${edit!.subcategory2}");
        print("subCategoryList2 ==> ${subCategoryList2.length}");

        for (int i = 0; i < subCategoryList2.length; i++) {
          if (edit!.subcategory2.toString() ==
              subCategoryList2[i].id.toString()) {
            subCategoryItem2 = subCategoryList2[i].name;
            break;
          }
        }
      } else {
        subCategoryItem2 = "";
      }

      if (edit!.location != "") {
        for (int i = 0; i < locationList.length; i++) {
          if (edit!.location.toString() == locationList[i].id.toString()) {
            locationItem = locationList[i].name;
            break;
          }
        }
      } else {
        locationItem = "";
      }

      if (edit!.owner != '') {
        for (int i = 0; i < ownerList.length; i++) {
          if (edit!.owner.toString() == ownerList[i].id.toString()) {
            ownerItem = ownerList[i].firstname;
            break;
          }
        }
      } else {
        ownerItem = "";
      }

      nameController.text = edit?.name ?? "";
      descriptionController.text = edit?.description ?? "";
      amountController?.text = edit?.acquiredAmt ?? "";
      tag = edit!.tag ?? "";
      print("path image ==> ${edit?.tag}");
    }
    editImage?.add(edit?.image1 ?? "");
    editImage?.add(edit?.image2 ?? "");
    editImage?.add(edit?.image3 ?? "");
    editImage?.add(edit?.image4 ?? "");
    editImage?.add("");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveEditValue();
    getDescriptionList();
    getNameList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  //   child: Container(
                  //     height: size.height / 5,
                  //     width: size.width,
                  //     decoration: BoxDecoration(
                  //         color: textFieldBackground,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: commonBorder),
                  //     child: Row(
                  //       children: [
                  //         // Stack(children: [
                  //         //   Row(children: [
                  //         //     Container(height: 20,width: 20,color: Colors.red,),
                  //         //     Container(height: 20,width: 20,color: Colors.green,),
                  //         //   ])
                  //         // ]),
                  //         IconButton(
                  //             onPressed: () {
                  //               if (pageIndex > 0) {
                  //                 setState(() {
                  //                   pageIndex--;
                  //                 });
                  //               }
                  //               pageController.jumpToPage(pageIndex);
                  //             },
                  //             icon: Icon(
                  //               Icons.chevron_left_outlined,
                  //               color: iconColor,
                  //             )),
                  //         Expanded(
                  //             child: PageView.builder(
                  //                 controller: pageController,
                  //                 itemCount: 5,
                  //                 itemBuilder:
                  //                     (BuildContext context, int index) {
                  //                   pageIndex = index;
                  //                   if (editImage![index] == '' &&
                  //                       fileImage!.length - 1 < index) {
                  //                     return Center(
                  //                         child: IconButton(
                  //                             onPressed: () =>
                  //                                 selectImageDialog(context),
                  //                             icon: Icon(
                  //                               size: 30,
                  //                               Icons.camera_alt_outlined,
                  //                               color: iconColor,
                  //                             )));
                  //                   } else {
                  //                     return editImage![index] == ''
                  //                         ? Image.file(
                  //                       fileImage![index],
                  //                       fit: BoxFit.cover,
                  //                     )
                  //                         : Image.network(editImage![index]);
                  //                   }
                  //                 })),
                  //         IconButton(
                  //             onPressed: () {
                  //               if (pageIndex < 4) {
                  //                 setState(() {
                  //                   pageIndex++;
                  //                 });
                  //               }
                  //               pageController.jumpToPage(pageIndex);
                  //             },
                  //             icon: Icon(
                  //               Icons.chevron_right_outlined,
                  //               color: iconColor,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Container(
                      height: size.height / 5,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: mainBackGroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder,/*image: DecorationImage(fit: BoxFit.fill,image: FileImage(File(imagePath[pageIndex])))*/),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 4),
                            child: InkWell(onTap: () {
                             if (pageIndex > 0) {
                              setState(() {
                                pageIndex--;
                              });
                            }
                            pageController.jumpToPage(pageIndex);
                            },child: Image.asset("asset/arrow-left.png",height: 30,width: 30,)),
                          ),

                          Expanded(
                              child: PageView.builder(
                                  controller: pageController,
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    pageIndex = index;
                                    if (editImage![index] == '' &&
                                        fileImage!.length - 1 < index) {
                                      return InkWell(onTap: () => selectImageDialog(context),
                                        child: Center(
                                            child: Image.asset("asset/image.png",height: 30,width: 30,)),
                                      );
                                      // IconButton(
                                      //     onPressed: () =>
                                      //         selectImageDialog(context),
                                      //     icon: Icon(
                                      //       size: 30,
                                      //       Icons.camera_alt_outlined,
                                      //       color: iconColor,
                                      //     ))
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(fit: BoxFit.cover,image: editImage![index] != ''
                                                ? NetworkImage(editImage![index])
                                              : FileImage(File(imagePath[index])
                                            ) as ImageProvider<Object> )),);
                                    }
                                  })),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 4),
                            child: InkWell(onTap: () {
                              if (pageIndex < 4) {
                                setState(() {
                                  pageIndex++;
                                });
                              }
                              pageController.jumpToPage(pageIndex);
                            },child: Image.asset("asset/arrow-right.png",height: 30,width: 30,)),
                          ),

                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Common.commonContainer(text: tag, size: size),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 8, 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (
                                          context) => const QRCodeScanner(),
                                    )).then((value) async {
                                  setState(() {
                                    tag = value;
                                  });
                                });
                              },
                              child: Image.asset(
                                "asset/qr-code.png", height: 40,),
                            ),
                          )),
                    ],
                  ),

                  Common.Text_field(size: size,
                    controller: nameController,
                    HintText: '*Name',
                    onChanged: (value) => onSearchName(value),
                  ),
                  searchNameList.isEmpty
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 158,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 22, top: 10),
                              itemCount: searchNameList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    nameController.text =
                                        searchNameList[index].name;
                                    searchNameList.clear();
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchNameList[index].name,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Common.Text_field(size: size,
                    controller: descriptionController,
                    HintText: 'Description',
                    onChanged: (value) => onSearchDescription(value),
                  ),
                  searchDescriptionList.isEmpty
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 158,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 22, top: 10),
                              itemCount: searchDescriptionList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    descriptionController.text =
                                    searchDescriptionList[index]
                                        .description!;
                                    searchDescriptionList.clear();
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchDescriptionList[index]
                                          .description!,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// category list
                  DropDownWidget(
                    showList: boolListCategory,
                    selectedItem: categoryItem,
                    defaultText: "Select Category",
                    onTap: () {
                      setState(() {
                        boolListCategory = !boolListCategory;
                      });
                    },
                  ),
                  boolListCategory
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Common.commonSearchTextFieldDropDown(
                              searchController: searchCategoryController,
                              onChanged: (value) =>
                                  filterSearchCategory(value),
                              search: searchAllList),
                          SizedBox(
                            height: 158,
                            child: (categoryNotFound == true)
                                ? Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 22),
                                  child: Text("No Category Found"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 22),
                                  child: Text(
                                      "Please Click + Button to Add New Category"),
                                ),
                                Center(child: IconButton(onPressed: () {
                                  showDialog(context: context,
                                    builder: (context) =>
                                        createNewCategoryDialog(
                                            context: context, sizes: size),);
                                }, icon: const Icon(Icons.add)),)
                              ],
                            )
                                : ListView.builder(
                              padding:
                              const EdgeInsets.only(left: 22),
                              itemCount: searchAllList.isEmpty
                                  ? categoryList.length
                                  : searchAllList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (searchAllList.isNotEmpty) {
                                      categoryId =
                                          searchAllList[index]
                                              .id
                                              .toString();
                                      subCategoryList1 =
                                          searchAllList[index]
                                              .subcategories;
                                      categoryItem =
                                          searchAllList[index].name;
                                    } else {
                                      categoryId =
                                          categoryList[index]
                                              .id
                                              .toString();
                                      subCategoryList1 =
                                          categoryList[index]
                                              .subcategories;
                                      categoryItem =
                                          categoryList[index].name;
                                    }
                                    boolListCategory = true;

                                    if (subCategoryItem1 != '') {
                                      subCategoryItem1 = '';
                                    }
                                    if (subCategoryItem2 != '') {
                                      subCategoryItem2 = '';
                                    }
                                    searchAllList.clear();
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchAllList.isEmpty
                                          ? categoryList[index].name
                                          : searchAllList[index]
                                          .name,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// subcatogary 1 list
                  DropDownWidget(
                    showList: boolListSubCategory1,
                    selectedItem: subCategoryItem1,
                    defaultText: "Select SubCategory 1",
                    onTap: () {
                      setState(() {
                        boolListSubCategory1 = !boolListSubCategory1;
                      });
                    },
                  ),
                  boolListSubCategory1
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Common.commonSearchTextFieldDropDown(
                              searchController:
                              searchSubCategory1Controller,
                              onChanged: (value) =>
                                  filterSearchSubCategory1(value),
                              search: searchAllList),
                          SizedBox(
                              height: 158,
                              child: (subCategoryList1.isEmpty)
                                  ? const Padding(
                                padding: EdgeInsets.only(left: 22),
                                child:
                                Text("No Subcategory 1 Found"),
                              )
                                  : ListView.builder(
                                padding:
                                const EdgeInsets.only(left: 22),
                                itemCount: searchAllList.isEmpty
                                    ? subCategoryList1.length
                                    : searchAllList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (searchAllList
                                            .isNotEmpty) {
                                          subCategory1Id =
                                              searchAllList[index]
                                                  .id;
                                          subCategoryItem1 =
                                              searchAllList[index]
                                                  .name;
                                        } else {
                                          subCategory1Id =
                                              subCategoryList1[
                                              index]
                                                  .id;
                                          subCategoryItem1 =
                                              subCategoryList1[
                                              index]
                                                  .name;
                                        }
                                        boolListSubCategory1 = true;

                                        if (subCategoryItem2 !=
                                            '') {
                                          subCategoryItem2 = '';
                                        }
                                        searchAllList.clear();
                                      });
                                      getSubCategories1(
                                          subCategory1Id);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          bottom: 8.0),
                                      child: Text(
                                        searchAllList.isEmpty
                                            ? subCategoryList1[
                                        index]
                                            .name
                                            : searchAllList[index]
                                            .name,
                                        style: commonTextStyle,
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
                  ),

                  /// subcategory 2  list
                  DropDownWidget(
                    showList: boolListSubCategory2,
                    selectedItem: subCategoryItem2,
                    defaultText: "Select SubCategory 2",
                    onTap: () {
                      setState(() {
                        boolListSubCategory2 = !boolListSubCategory2;
                      });
                    },
                  ),
                  boolListSubCategory2
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: textFieldBackground,
                              borderRadius: BorderRadius.circular(10),
                              border: commonBorder),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Common.commonSearchTextFieldDropDown(
                                searchController:
                                searchSubCategory2Controller,
                              ),
                              SizedBox(
                                  height: 158,
                                  child: (subCategoryList2.isEmpty)
                                      ? const Padding(
                                    padding:
                                    EdgeInsets.only(left: 22),
                                    child: Text(
                                        "No Subcategory 2 Found"),
                                  )
                                      : ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 22),
                                    itemCount:
                                    subCategoryList2.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            subCategory2Id =
                                                locationList[index]
                                                    .id;
                                            subCategoryItem2 =
                                                subCategoryList2[
                                                index]
                                                    .name;
                                            boolListSubCategory2 =
                                            true;
                                            searchAllList.clear();
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            subCategoryList2[index]
                                                .name,
                                            style: commonTextStyle,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// location list
                  DropDownWidget(
                    showList: boolListLocation,
                    selectedItem: locationItem,
                    defaultText: "Select Location",
                    onTap: () {
                      setState(() {
                        boolListLocation = !boolListLocation;
                      });
                    },
                  ),
                  boolListLocation
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Common.commonSearchTextFieldDropDown(
                              searchController: searchLocationController,
                              onChanged: (value) =>
                                  filterSearchLocation(value),
                              search: searchAllList),
                          SizedBox(
                            height: 158,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 22),
                              itemCount: searchAllList.isEmpty
                                  ? locationList.length
                                  : searchAllList.length,
                              itemBuilder: (context, index) {
                                return boolListLocation
                                    ? null
                                    : InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (searchAllList
                                          .isNotEmpty) {
                                        locationId =
                                            searchAllList[index].id;
                                        locationItem =
                                            searchAllList[index]
                                                .name;
                                      } else {
                                        locationId =
                                            locationList[index].id;
                                        locationItem =
                                            locationList[index]
                                                .name;
                                      }
                                      boolListLocation = true;
                                      searchAllList.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchAllList.isEmpty
                                          ? locationList[index].name
                                          : searchAllList[index]
                                          .name,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// depreciation list
                  DropDownWidget(
                    showList: boolListDepreciation,
                    selectedItem: depreciationItem,
                    defaultText: "Select Depreciation",
                    onTap: () {
                      setState(() {
                        boolListDepreciation = !boolListDepreciation;
                      });
                    },
                  ),
                  boolListDepreciation
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Common.commonSearchTextFieldDropDown(
                              searchController:
                              searchDepreciationController,
                              onChanged: (value) =>
                                  filterSearchDepreciation(value),
                              search: searchAllList),
                          SizedBox(
                            height: 158,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 22),
                              itemCount: searchAllList.isEmpty
                                  ? locationList.length
                                  : searchAllList.length,
                              itemBuilder: (context, index) {
                                return boolListDepreciation
                                    ? null
                                    : InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (searchAllList
                                          .isNotEmpty) {
                                        depreciationId =
                                            searchAllList[index].id;
                                        depreciationItem =
                                            searchAllList[index]
                                                .name;
                                      } else {
                                        depreciationId =
                                            depreciationList[index]
                                                .id;
                                        depreciationItem =
                                            depreciationList[index]
                                                .name;
                                      }
                                      boolListDepreciation = true;
                                      searchAllList.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchAllList.isEmpty
                                          ? depreciationList[index]
                                          .name
                                          : searchAllList[index]
                                          .name,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// owner list
                  DropDownWidget(
                    showList: boolListOwner,
                    selectedItem: ownerItem,
                    defaultText: "*Select Owner",
                    onTap: () {
                      setState(() {
                        boolListOwner = !boolListOwner;
                      });
                    },
                  ),
                  boolListOwner
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Common.commonSearchTextFieldDropDown(
                              searchController: searchOwnerController,
                              onChanged: (value) =>
                                  filterSearchOwner(value),
                              search: searchAllList),
                          SizedBox(
                            height: 158,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 22),
                              itemCount: searchAllList.isEmpty
                                  ? ownerList.length
                                  : searchAllList.length,
                              itemBuilder: (context, index) {
                                return boolListOwner
                                    ? null
                                    : InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (searchAllList
                                          .isNotEmpty) {
                                        ownerId =
                                            searchAllList[index].id;
                                        ownerItem =
                                            searchAllList[index]
                                                .firstname;
                                      } else {
                                        ownerId =
                                            ownerList[index].id;
                                        ownerItem = ownerList[index]
                                            .firstname;
                                      }
                                      boolListOwner = true;
                                      searchAllList.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Text(
                                      searchAllList.isEmpty
                                          ? ownerList[index]
                                          .firstname
                                          : searchAllList[index]
                                          .firstname,
                                      style: commonTextStyle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Common.Text_field(size: size,
                    HintText: 'Acquired Amount',
                    controller: amountController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomContainer(
                      size: size,
                      color: Colors.white,
                      width: size.width * .95,
                      decoration: BoxDecoration(
                          color: textFieldBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: commonBorder),
                      labelText: 'Acquired Date',
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(left: 16.0, right: 8),
                            //   child: Icon(
                            //     Icons.date_range_outlined,
                            //     color: prefixIconColor,
                            //   ),
                            // ),
                            SizedBox(width: 8,),
                            Expanded(
                                child: acquiredDate != ''
                                    ? Text(
                                  acquiredDate,
                                  style: commonSelectedStyle,
                                )
                                    : Text(
                                  "Acquired Date",
                                  style: commonHintStyle,
                                )),
                            IconButton(
                                onPressed: () async {
                                  DateTime pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100)) as DateTime;
                                  if (pickedDate != null) {
                                    String formattedDate =
                                    DateFormat('dd-MM-yyyy')
                                        .format(pickedDate);
                                    setState(() {
                                      acquiredDate = formattedDate;
                                    });
                                  }
                                },
                                icon: Icon(
                                  size: 25,
                                  Icons.date_range_outlined,
                                  color: iconColor,
                                ))
                          ]),
                    ),
                  ),


                  boolUploadingData == false
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: inactiveButton,
                          borderRadius: BorderRadius.circular(10)),
                      child: const CircularProgressIndicator(
                          color: Colors.white),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        formValidation();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: submitButton,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                    child: InkWell(
                      onTap: () {
                        clearAllValue();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: submitButton,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('Clear Data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectImageDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select For Upload"),
          actions: [
            TextButton(
                onPressed: () async {
                  selectImages(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Text("Gallery")),
            TextButton(
                onPressed: () async {
                  selectImages(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Text("Camera"))
          ],
        );
      },
    );
  }

  formValidation() async {
    if (nameController.text.isEmpty) {
      showSnackBar('Please Enter Name', context);
    } else if (ownerItem == '') {
      showSnackBar('Please select Owner', context);
    } else if (tag == '') {
      showSnackBar('Please Scan QR for Tag', context);
    } else {
      setState(() {
        boolUploadingData = false;
      });
      AssetsPost assets = AssetsPost(
          name: nameController.text,
          description: descriptionController.text,
          category: categoryId,
          subcategory1: subCategory1Id,
          subcategory2: subCategory2Id,
          location: locationId,
          depreciation: depreciationId,
          owner: ownerId!,
          acquiredAmt: amountController?.text,
          tag: tag,
          // : acquiredDate,
          image1: fileImage!.isNotEmpty
              ? await MultipartFile.fromFile(fileImage![0].path,
              filename: 'image1.jpg')
              : null,
          image2: fileImage!.length > 1
              ? await MultipartFile.fromFile(fileImage![1].path,
              filename: 'image2.jpg')
              : null,
          image3: fileImage!.length > 2
              ? await MultipartFile.fromFile(fileImage![2].path,
              filename: 'image3.jpg')
              : null,
          image4: fileImage!.length > 3
              ? await MultipartFile.fromFile(fileImage![3].path,
              filename: 'image4.jpg')
              : null,
          invoice: null);
      print("Aseets ==> ${assets.image2.toString()}");
      postData(assets: assets).then((value) {
        if (value) {
          Common.commonToastMessage(
              messages: "Successful to Save Data", colorBG: Colors.black);
        } else {
          Common.commonToastMessage(
              messages: "Unsuccessful to Save Data", colorBG: Colors.red);
        }
        setState(() {
          boolUploadingData = true;
        });
      });
    }
  }

  clearAllValue() {
    tag = '';
    nameController.clear();
    descriptionController.clear();
    categoryItem = '';
    subCategoryItem1 = '';
    subCategoryItem2 = '';
    locationItem = '';
    depreciationItem = '';
    ownerItem = '';
    amountController?.clear();
    acquiredDate = '';
    fileImage!.clear();

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    amountController?.dispose();
  }

  /// name search
  onSearchName(String text) async {
    searchNameList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    nameList.forEach((userDetail) {
      if (userDetail.name.toLowerCase().startsWith(text.toLowerCase()) ||
          userDetail.name.toUpperCase().startsWith(text.toUpperCase())) {
        searchNameList.add(userDetail);
      }
    });
    setState(() {});
  }

  /// description search
  onSearchDescription(String text) async {
    searchDescriptionList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    descriptionList.forEach((userDetail) {
      if (userDetail.description != null) {
        if (userDetail.description!
            .toLowerCase()
            .startsWith(text.toLowerCase()) ||
            userDetail.description!
                .toUpperCase()
                .startsWith(text.toUpperCase())) {
          searchDescriptionList.add(userDetail);
        }
      }
    });
    setState(() {});
  }

  ///select image
  selectImages(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);

    if (result != null) {
      final dir = await path_provider.getExternalStorageDirectory();
      int name = DateTime
          .now()
          .millisecondsSinceEpoch;
      final targetPath = '${dir!.path}/$name.jpg';
      var compressFile = await FlutterImageCompress.compressAndGetFile(
        result.path,
        targetPath,
        minWidth: 372,
        minHeight: 372,
      );
      imagePath.add(compressFile!.path);
      fileImage!.add(File(compressFile.path));
      setState(() {});
    } else {
      // User canceled the picker
      print("image not selected...");
    }
  }

  /// Category search filter
  filterSearchCategory(String text) async {
    categoryNotFound = false;
    searchAllList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    } else {
      categoryList.forEach((userDetail) {
        if (userDetail.name.toLowerCase().startsWith(text.toLowerCase()) ||
            userDetail.name.toUpperCase().startsWith(text.toUpperCase())) {
          searchAllList.add(userDetail);
        }
      });
      if (searchAllList.isEmpty) {
        categoryNotFound = true;
      }
    }

    setState(() {});
  }

  /// Subcategory 1 search filter
  filterSearchSubCategory1(String text) async {
    searchAllList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    subCategoryList1.forEach((userDetail) {
      if (userDetail.name.toLowerCase().startsWith(text.toLowerCase()) ||
          userDetail.name.toUpperCase().startsWith(text.toUpperCase())) {
        searchAllList.add(userDetail);
      }
    });
    setState(() {});
  }

  /// Subcategory2 search filter

  /// Location search filter
  filterSearchLocation(String text) async {
    searchAllList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    locationList.forEach((userDetail) {
      if (userDetail.name.toLowerCase().startsWith(text.toLowerCase()) ||
          userDetail.name.toUpperCase().startsWith(text.toUpperCase())) {
        searchAllList.add(userDetail);
      }
    });
    setState(() {});
  }

  /// Depreciation search filter
  filterSearchDepreciation(String text) async {
    searchAllList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    depreciationList.forEach((userDetail) {
      if (userDetail.name.toLowerCase().startsWith(text.toLowerCase()) ||
          userDetail.name.toUpperCase().startsWith(text.toUpperCase())) {
        searchAllList.add(userDetail);
      }
    });
    setState(() {});
  }

  /// owner search filter
  filterSearchOwner(String text) async {
    searchAllList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    ownerList.forEach((userDetail) {
      if (userDetail.firstname.toLowerCase().startsWith(text.toLowerCase()) ||
          userDetail.firstname.toUpperCase().startsWith(text.toUpperCase())) {
        searchAllList.add(userDetail);
      }
    });
    setState(() {});
  }
}
