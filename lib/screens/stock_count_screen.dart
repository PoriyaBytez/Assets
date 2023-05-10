import 'package:assets/api/servies/api_servies.dart';
import 'package:assets/screens/assets_edinting.dart';
import 'package:assets/screens/product_details_screen.dart';
import 'package:assets/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../api/models/asset_get_model.dart';
import '../utils/const_colors.dart';
import '../widgets/Common_widget.dart';
import '../widgets/dialogs.dart';
import 'drawer_screen.dart';

class StockCountScreen extends StatefulWidget {
  const StockCountScreen({Key? key}) : super(key: key);

  @override
  State<StockCountScreen> createState() => _StockCountScreenState();
}

class _StockCountScreenState extends State<StockCountScreen> {
  List<AssetsGet> searchAssets = [];
  TextEditingController searchController = TextEditingController();

  List<AssetsGet> assetList = [];
  bool annul = false;

  /// filter button variable
  bool categoryFilter = false;
  bool locationFilter = false;
  bool ownerFilter = false;
  bool descriptionFilter = false;
  bool? filterLoadingIndicator;
  bool showEmptyScreen = false;

  getAssetData() async {
    assetList = await getAllDataFromAssets();
    print("assetList ==> ${assetList.length}");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAssetData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 62),
          child: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: whiteColor, // Change Custom Drawer Icon Color
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              elevation: 1,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: mainBackGroundColor,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 8, right: 4),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) => onSearchTextChanged(value),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Search",
                              hintStyle:
                                  TextStyle(fontSize: 18, color: whiteColor)),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/QRscanner")
                                .then((value) {
                              if (value != null) {
                                onClickTagFilter(value);
                              }
                            });
                          },
                          child: Icon(
                            Icons.qr_code,
                            color: whiteColor,
                          )),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              leadingWidth: 30,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                      onTap: () {
                        searchController.clear();
                        searchAssets.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor, shape: BoxShape.circle),
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: mainBackGroundColor,
                        ),
                      )),
                ),
              ]),
        ),
        drawer: drawerWidget(context),
        body: assetList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  searchAssets.clear();
                  await getAssetData();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(searchAssets.isEmpty ? "Stock Count : " : "Search Count"),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: size.width * .1,
                          decoration: BoxDecoration(color: mainBackGroundColor,borderRadius: BorderRadius.circular(10)),
                          child: Text(searchAssets.isEmpty ? assetList.length.toString() : searchAssets.length.toString(),
                              style: TextStyle(color: Colors.white)),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () => Navigator.pushNamed(context, "/filter")
                                    .then((value) {
                                  if (value == true) {
                                    onClickCategoryFilter();
                                  } else if (value == null) {
                                  } else {
                                    setState(() {
                                      searchAssets.clear();
                                    });
                                  }
                                }),
                            child: Row(
                              children: [
                                Text("filter".toUpperCase(),
                                    style: const TextStyle(color: Colors.blue)),
                                const Icon(
                                  Icons.tune,
                                  color: Colors.blue,
                                )
                              ],
                            )),
                        SizedBox(width: size.width * .02,),
                      ]),
                      const Divider(thickness: 0.8, color: Colors.grey),
                      Expanded(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: filterLoadingIndicator == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : showEmptyScreen == true
                                  ? const Center(
                                      child: Text(
                                          "No results for filter criteria"),
                                    )
                                  : SlidableAutoCloseBehavior(
                                      closeWhenOpened: true,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: searchAssets.isEmpty
                                            ? 20 //assetList.length
                                            : searchAssets.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 8, 0),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: .5,
                                                      color:
                                                          commonBorderColor)),
                                              child: Slidable(
                                                startActionPane: ActionPane(
                                                  extentRatio: .21,
                                                  motion: const StretchMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (context) {},
                                                      backgroundColor:
                                                          Colors.pinkAccent,
                                                      foregroundColor:
                                                          whiteColor,
                                                      icon: Icons.delete,
                                                      // label: 'Delete',
                                                    ),
                                                  ],
                                                ),
                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetails(
                                                          assets: searchAssets
                                                                  .isEmpty
                                                              ? assetList[index]
                                                              : searchAssets[
                                                                  index],
                                                        ),
                                                      )),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height * .12,
                                                          width:
                                                              size.width * .28,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image: (searchAssets.isEmpty
                                                                            ? assetList[index].image1 !=
                                                                                null
                                                                            : searchAssets[index].image1 !=
                                                                                null)
                                                                        ? NetworkImage(
                                                                            "${assetList[index].image1}",
                                                                          )
                                                                        : const AssetImage(
                                                                            "asset/image.png",
                                                                          ) as ImageProvider<
                                                                            Object>,
                                                                  )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          .02,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          .6,
                                                                  child: Text(
                                                                      maxLines:
                                                                          2,
                                                                      searchAssets
                                                                              .isEmpty
                                                                          ? "${assetList[index].name}"
                                                                          : "${searchAssets[index].name}",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              textCommonColor)),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          .6,
                                                                  child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        commonButtonAssetScreen(
                                                                            onTap: () =>
                                                                                showModalBottomSheet(context: context, builder: (context) => decommissionDialog(context: context, sizes: size)),
                                                                            imagePath: "asset/acc.png",
                                                                            colorBG: icon1BGColor),
                                                                        commonButtonAssetScreen(
                                                                            onTap: () => Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => AssetEditing(assets: searchAssets.isEmpty ? assetList[index] : searchAssets[index]),
                                                                                )),
                                                                            imagePath: "asset/edit.png",
                                                                            colorBG: icon2BGColor),
                                                                        commonButtonAssetScreen(
                                                                            onTap: () =>
                                                                                showModalBottomSheet(context: context, builder: (context) => checkInDialog(context: context, sizes: size)),
                                                                            imagePath: "asset/logout.png",
                                                                            colorBG: icon3BGColor),
                                                                        commonButtonAssetScreen(
                                                                            onTap: () => showModalBottomSheet(
                                                                                useSafeArea: true,
                                                                                context: context,
                                                                                builder: (context) => serviceReminder(sizes: size, context: context, title: 'Service Reminder', details: "Details :", detailsHint: 'Check pressure and gauhe\nfunction', serviceDate: "Service Date", assetId: searchAssets.isEmpty ? assetList[index].id : searchAssets[index].id)),
                                                                            imagePath: "asset/Setting.png",
                                                                            colorBG: icon4BGColor),
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
                                                                )
                                                              ]),
                                                        ),
                                                        const Spacer(),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
        // floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, '/assetEditing'),child: Image.asset("assets/with-plus.png")),
        floatingActionButton: InkWell(
          onTap: () => Navigator.pushNamed(context, '/assetEditing'),
          child: Image.asset(
            "asset/with-plus.png",
            width: 50,
            height: 50,
          ),
        ));
  }

  /// On Search Filter
  onSearchTextChanged(String text) async {
    searchAssets.clear();
    if (text.isEmpty) {
      // FocusManager.instance.primaryFocus?.unfocus();
      setState(() {});
      return;
    }
    assetList.forEach((userDetail) {
      if (userDetail.name != null) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase()) ||
            userDetail.name!.toUpperCase().contains(text.toUpperCase())) {
          searchAssets.add(userDetail);
        }
      }
    });
    setState(() {});
  }

  /// Tag Scan filter
  onClickTagFilter(value) async {
    searchAssets.clear();
    assetList.forEach((userDetail) {
      if (userDetail.tag != null) {
        if (userDetail.tag.contains(value)) {
          searchAssets.add(userDetail);
        }
      }
    });
    setState(() {});
  }

  /// filter data from main list
  onClickCategoryFilter() async {
    searchAssets.clear();
    filterLoadingIndicator = true;
    showEmptyScreen = false;
    // for(int i=0;i<filterValueCategory.length;i++) {
    //   searchAssets.retainWhere((element) =>
    //       element.category.toString().contains("${filterValueCategory[i]}"));
    // }
    // searchAssets.where((i) => i.category.toString().contains("100100")).toList();
    if (filterValueCategory.isNotEmpty &&
        filterValueLocation.isNotEmpty &&
        filterValueOwner.isNotEmpty &&
        filterValueDepreciation.isNotEmpty) {
      assetList.forEach((element) {
        if (element.category != null &&
            element.location != null &&
            element.owner != null &&
            element.depreciation != null) {
          for (int i = 0; i < filterValueCategory.length; i++) {
            for (int j = 0; j < filterValueLocation.length; j++) {
              for (int k = 0; k < filterValueOwner.length; k++) {
                for (int l = 0; l < filterValueDepreciation.length; l++) {
                  if (element.category.contains(filterValueCategory[i]) &&
                      element.location.contains(filterValueLocation[j]) &&
                      element.owner.contains(filterValueOwner[k]) &&
                      element.depreciation
                          .contains(filterValueDepreciation[l])) {
                    searchAssets.add(element);
                  }
                }
              }
            }
          }
        }
      });
    } else if (filterValueCategory.isNotEmpty &&
        filterValueLocation.isNotEmpty &&
        filterValueOwner.isNotEmpty) {
      assetList.forEach((element) {
        if (element.category != null && element.location != null && element.owner != null) {
          for (int i = 0; i < filterValueCategory.length; i++) {
            for (int j = 0; j < filterValueLocation.length; j++) {
              for (int k = 0; k < filterValueOwner.length; k++) {
                if (element.category.contains(filterValueCategory[i].toString()) &&
                    element.location.contains(filterValueLocation[j].toString()) &&
                    element.owner.contains(filterValueOwner[k].toString())) {
                  searchAssets.add(element);
                }
              }
            }
          }
        }
      });
    } else if (filterValueCategory.isNotEmpty &&
        filterValueLocation.isNotEmpty) {
      assetList.forEach((element) {
        if (element.category != null && element.location != null) {
          for (int i = 0; i < filterValueCategory.length; i++) {
            for (int j = 0; j < filterValueLocation.length; j++) {
              if (element.category.contains(filterValueCategory[i]) &&
                  element.location.contains(filterValueLocation[j])) {
                searchAssets.add(element);
              }
            }
          }
        }
      });
    } else if (filterValueCategory.isNotEmpty) {
      assetList.forEach((element) {
        if (element.category != null) {
          for (int i = 0; i < filterValueCategory.length; i++) {
            if (element.category.contains(filterValueCategory[i])) {
              print("object loop ==> ${filterValueCategory[i]}");
              searchAssets.add(element);
            }
          }
        }
      });
    } else if (filterValueLocation.isNotEmpty) {
      assetList.forEach((element) {
        if (element.location != null) {
          for (int i = 0; i < filterValueLocation.length; i++) {
            if (element.location.contains(filterValueLocation[i])) {
              searchAssets.add(element);
            }
          }
        }
      });
    } else if (filterValueOwner.isNotEmpty) {
      assetList.forEach((element) {
        if (element.owner != null) {
          for (int i = 0; i < filterValueOwner.length; i++) {
            if (element.owner.contains(filterValueOwner[i])) {
              searchAssets.add(element);
            }
          }
        }
      });
    } else if (filterValueDepreciation.isNotEmpty) {
      assetList.forEach((element) {
        if (element.depreciation != null) {
          for (int i = 0; i < filterValueDepreciation.length; i++) {
            if (element.depreciation.contains(filterValueDepreciation[i])) {
              searchAssets.add(element);
            }
          }
        }
      });
    }
    setState(() {
      filterLoadingIndicator = false;
    });
    if (searchAssets.isEmpty) {
      setState(() {
        showEmptyScreen = true;
      });
    }
    print("element.values ==> ${searchAssets.length}");
    setState(() {});
  }

  feature_select({String? name, GestureTapCallback? onTap, bool? feature}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(2),
              // margin: EdgeInsets.only(right: 3.w),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.black, width: 2)),
              child: feature == false
                  ? const SizedBox()
                  : Container(
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    )),
        ),
        // SizedBox(
        //   width: 2.w,
        // ),
        Text(
          name!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
