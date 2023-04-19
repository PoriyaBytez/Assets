import 'package:assets/api/servies/api_servies.dart';
import 'package:assets/screens/home_screen.dart';
import 'package:assets/utils/variables.dart';
import 'package:flutter/material.dart';
import '../api/models/asset_get_model.dart';
import 'drawer_screen.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  List<AssetsGet> searchAssets = [];
  TextEditingController searchController = TextEditingController();
  List<AssetsGet> assetList = [];
  Size? size;

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
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 62),
        child: AppBar(
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: "Search",
                            hintStyle: TextStyle(fontSize: 18)),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/QRscanner")
                              .then((value) {
                            if (value != null) {
                              onClickTagFilter(value);
                            }
                            print("tag value ==> $value");
                          });
                        },
                        child: const Icon(Icons.qr_code)),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            leadingWidth: 30,
            actions: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        searchController.clear();
                        searchAssets.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {});
                      },
                      child: const Icon(size: 30, Icons.cancel_outlined)),
                  const Icon(size: 30, Icons.check_box),
                ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        const Text("Office"),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0x6F755959),
                              ),
                              child: Text(
                                searchAssets.isEmpty
                                    ? "${assetList.length}"
                                    : "${searchAssets.length}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () => Navigator.pushNamed(context, "/filter")
                                    .then((value) {
                                  print("object ==> $value");
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
                                  Icons.filter_list,
                                  color: Colors.blue,
                                )
                              ],
                            )),
                      ]),
                    ),
                    const Divider(thickness: 0.8, color: Colors.grey),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: filterLoadingIndicator== true ? Center(child: CircularProgressIndicator(),) : showEmptyScreen == true
                                ? const Center(
                                    child:
                                        Text("No results for filter criteria"),
                                  )
                                : ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: searchAssets.isEmpty
                                        ? assetList.length
                                        : searchAssets.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width: size!.width,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.grey,
                                                ),
                                                child: (searchAssets.isEmpty
                                                        ? assetList[index]
                                                                .image1 !=
                                                            null
                                                        : searchAssets[index]
                                                                .image1 !=
                                                            null)
                                                    ? Icon(Icons
                                                        .print) /*Image.network(
                              "${assetList[index].image1}",
                              fit: BoxFit.fill,
                            )*/
                                                    : const Icon(Icons
                                                        .production_quantity_limits),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: SizedBox(
                                                  width: size!.width / 2,
                                                  child: Text(
                                                      searchAssets.isEmpty
                                                          ? "${assetList[index].name}"
                                                          : "${searchAssets[index].name}",
                                                      overflow:
                                                          TextOverflow.clip,
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Align(
                                                  widthFactor: 2,
                                                  heightFactor: 3.3,
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return HomeScreen(
                                                              assets: searchAssets
                                                                      .isEmpty
                                                                  ? assetList[
                                                                      index]
                                                                  : searchAssets[
                                                                      index],
                                                            );
                                                          },
                                                        ));
                                                        // Navigator.pushNamed(
                                                        //     context, '/home');
                                                      },
                                                      child: const Icon(
                                                          Icons.edit)),
                                                ),
                                              )
                                            ]),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider(
                                        thickness: 0.8,
                                        color: Colors.grey,
                                      );
                                    },
                                  )),
                      ),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
            // onClickCategoryFilter();
          },
          child: const Icon(Icons.add)),
    );
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
    print("filterValueCategory ==> $filterValueCategory");
    print("filterValueLocation ==> $filterValueLocation");
    print("filterValueOwner ==> $filterValueOwner");
    print("filterValueDepreciation ==> $filterValueDepreciation");
    // for(int i=0;i<filterValueCategory.length;i++) {
    //   searchAssets.retainWhere((element) =>
    //       element.category.toString().contains("${filterValueCategory[i]}"));
    // }
    // searchAssets.where((i) => i.category.toString().contains("100100")).toList();
    print("searchAssets 2 ==> ${searchAssets.length}");
    if (filterValueCategory.isNotEmpty &&
        filterValueLocation.isNotEmpty &&
        filterValueOwner.isNotEmpty &&
        filterValueDepreciation.isNotEmpty) {
      assetList.forEach((element) {
        if (element.category != null && element.location != null && element.owner != null && element.depreciation != null) {
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
        if (element.category != null && element.location != null) {
          for (int i = 0; i < filterValueCategory.length; i++) {
            for (int j = 0; j < filterValueLocation.length; j++) {
              for (int k = 0; k < filterValueOwner.length; k++) {
                if (element.category.contains(filterValueCategory[i]) &&
                    element.location.contains(filterValueLocation[j]) &&
                    element.owner.contains(filterValueOwner[k])) {
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

  /// Depreciation filter
// onClickDepreciationFilter(Iterable<String> value) async {
//   // searchAssets.clear();
//   assetList.forEach((userDetail) {
//     // for (int i = 0; i < value.length; i++) {
//     if (userDetail.depreciation != null) {
//       if (userDetail.depreciation.contains(
//           value.toString().replaceAll("(", "").replaceAll(")", ""))) {
//         searchAssets.add(userDetail);
//       }
//     }
//     // }
//   });
//   setState(() {});
// }
}
