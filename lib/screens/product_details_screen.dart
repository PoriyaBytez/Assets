import 'dart:io';

import 'package:assets/api/models/asset_get_model.dart';
import 'package:flutter/material.dart';

// import 'package:sizer/sizer.dart';
import '../utils/const_colors.dart';
import '../utils/static_function.dart';
import '../widgets/Common_widget.dart';
import '../widgets/dialogs.dart';
import 'assets_edinting.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.assets}) : super(key: key);
  AssetsGet assets;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  AssetsGet? get edit => widget.assets;
  TextStyle parameterTextStyle =
      const TextStyle(fontSize: 16, color: Colors.grey);
  TextStyle valueTextStyle = const TextStyle(fontSize: 22);
  List<String>? editImage = [];
  int pageIndex = 0;
  List<File>? fileImage = [];
  final PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    super.initState();
    saveEditValue();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: size.height * .25,
            // height: 30.h,
            width: size.width,
            decoration:  BoxDecoration(
                color: mainBackGroundColor,
                /*image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.assets.image1))*/
                ),
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
                    child: editImage!.isEmpty
                        ? const Center(
                            child: Text("NO Image Available For this product"))
                        : PageView.builder(
                            controller: pageController,
                            itemCount: editImage!.length,
                            itemBuilder: (BuildContext context, int index) {
                              pageIndex = index;
                              /*if (editImage![index] == '' &&
                          fileImage!.length - 1 < index) */
                              {
                                return Image.network(
                                    fit: BoxFit.fill, editImage![index]);
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
          SizedBox(height: size.height * .01),
          Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                commonButtonDetailScreen(
                    size: size,
                    onTap: () => showModalBottomSheet(context: context, builder: (context) => decommissionDialog(context: context,sizes: size)),
                    title: "Decommission",
                    imagePath: "asset/acc.png",
                    colorBG: icon1BGColor),
               commonButtonDetailScreen(
                   size: size,
                   onTap: () =>
                       showModalBottomSheet(
                           context: context,
                           builder: (
                               context) =>
                               checkInDialog(
                                   context: context,
                                   sizes: size)),
                   title: "Check Out",
                   imagePath: "asset/edit.png",
                   colorBG: icon2BGColor),
                commonButtonDetailScreen(
                    size: size,
                    onTap: () =>
                        showModalBottomSheet(
                            context: context,
                            builder: (
                                context) =>
                                checkInDialog(
                                    context: context,
                                    sizes: size)),
                    title: "Service",
                    imagePath: "asset/logout.png",
                    colorBG: icon3BGColor),
                commonButtonDetailScreen(
                    size: size,
                    onTap: () =>
                    showModalBottomSheet(useSafeArea: true,context: context, builder: (context) => serviceReminder(
                        sizes: size,
                        context: context,
                        title: 'Service Reminder',
                        details: "Details :",
                        detailsHint: 'Check pressure and gauhe\nfunction',
                        serviceDate: "Service Date",
                        assetId: widget.assets.id)),
                    title: "Edit",
                    imagePath: "asset/Setting.png",
                    colorBG: icon4BGColor)
                // Padding(
                //   padding:
                //   const EdgeInsets.only(
                //       right: 8.0),
                //   child: InkWell(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (
                //                   context) {
                //                 return HomeScreen(
                //                   assets: searchAssets
                //                       .isEmpty
                //                       ? assetList[index]
                //                       : searchAssets[index],
                //                 );
                //               },
                //             ));
                //       },
                //       child: const Icon(
                //           Icons.edit)),
                // ),
              ]),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly
          //   children: [
          //     Expanded(
          //       child: commonIconBuild(
          //           onTap: () => showModalBottomSheet(
          //               context: context,
          //               builder: (context) =>
          //                   decommissionDialog(context: context, sizes: size)),
          //           // onTap: () => showModalBottomSheet(context: context, builder: (context) => decommissionDialog(context: context,sizes: size)),
          //           icon: Icons.edit_note_outlined,
          //           label: "Decommission"),
          //     ),
          //     Expanded(
          //       child: commonIconBuild(
          //           onTap: () => showModalBottomSheet(
          //               context: context,
          //               builder: (context) =>
          //                   checkInDialog(context: context, sizes: size)),
          //           icon: Icons.exit_to_app_outlined,
          //           label: "Check Out"),
          //     ),
          //     Expanded(
          //       child: commonIconBuild(
          //           onTap: () => showModalBottomSheet(
          //                 context: context,
          //                 builder: (context) => serviceReminder(
          //                   sizes: size,
          //                   context: context,
          //                   title: 'Service  Reminder',
          //                   details: "Details :",
          //                   detailsHint: 'Check pressure and gauhe\nfunction',
          //                   serviceDate: "ServiceData",
          //                 ),
          //               ),
          //           icon: Icons.settings,
          //           label: "Service"),
          //     ),
          //     Expanded(
          //       child: commonIconBuild(
          //           onTap: () => Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return HomeScreen(
          //                     assets: widget.assets,
          //                   );
          //                 },
          //               )),
          //           icon: Icons.edit,
          //           label: "Edit"),
          //     )
          //   ],
          // ),
          SizedBox(height: size.height * .01),
          detailScreenCommonContainer(title: "Name",value: widget.assets.name),
          detailScreenCommonContainer(title: "Description",value: widget.assets.description ?? ""),
          detailScreenCommonContainer(title: "Categories",value: categoryItem),
          detailScreenCommonContainer(title: "Subcategory 1",value: subCategoryItem1),
          detailScreenCommonContainer(title: "Subcategory 2",value: subCategoryItem2),
          detailScreenCommonContainer(title: "Status",value: widget.assets.status ?? ""),
          detailScreenCommonContainer(title: "Depreciation",value:depreciationItem),
          detailScreenCommonContainer(title: "Owner",value: ownerItem),
          detailScreenCommonContainer(title: "Date Acquired",value: widget.assets.acquired ?? ""),
          detailScreenCommonContainer(title: "Amount Acquired",value: widget.assets.acquiredAmt ?? ""),


        ]),
      )),
    );
  }

  /// When try to edit the data
  saveEditValue() {
    if (edit != null) {
      if (edit!.category != "") {
        for (int i = 0; i < categoryList.length; i++) {
          if (edit!.category.toString() == categoryList[i].id.toString()) {
            categoryItem = categoryList[i].name;
            subCategoryList1 = categoryList[i].subcategories;
            break;
          }
        }
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
      }

      if (edit!.subcategory2 != "") {
        for (int i = 0; i < subCategoryList2.length; i++) {
          if (edit!.subcategory2.toString() ==
              subCategoryList2[i].id.toString()) {
            subCategoryItem2 = subCategoryList2[i].name;
            break;
          }
        }
      }

      if (edit!.location != "") {
        for (int i = 0; i < locationList.length; i++) {
          if (edit!.location.toString() == locationList[i].id.toString()) {
            locationItem = locationList[i].name;
            break;
          }
        }
      }

      if (edit!.owner != '') {
        for (int i = 0; i < ownerList.length; i++) {
          if (edit!.owner.toString() == ownerList[i].id.toString()) {
            ownerItem = ownerList[i].firstname;
            break;
          }
        }
      }
    }
    if (edit!.image1 != null) {
      editImage!.add(edit!.image1);
    }
    if (edit!.image2 != null) {
      editImage!.add(edit!.image2);
    }
    if (edit!.image3 != null) {
      editImage!.add(edit!.image3);
    }
    if (edit!.image4 != null) {
      editImage!.add(edit!.image4);
    }
  }
}
