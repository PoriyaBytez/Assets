import 'package:assets/utils/const_colors.dart';
import 'package:assets/utils/static_function.dart';
import 'package:flutter/material.dart';

import '../utils/variables.dart';
import '../widgets/dialogs.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int tappedIndex = 0;
  List<bool> selectAllList = [false,false,false,false];
 bool selectAll = false;
  TextStyle? selectedStyle =
      TextStyle(color: Color(0xff4b4f65), fontWeight: FontWeight.w500);
  TextStyle? unselectedStyle = TextStyle(
    color: Color(0xff9fa4b1),
  );
  List<String> selectCategoryItemId = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("filters".toUpperCase()),
                Spacer(),
                TextButton(
                    onPressed: () => clearAllFilter(),
                    child: Text("clear all".toUpperCase())),
                Image.asset(
                  "asset/eraser.png",
                  height: 25,
                  width: 20,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: commonBorderColor)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterAssets.length,
                      itemBuilder: (context, index) {
                        return
                            ListTile(
                          onTap: () {
                            tappedIndex = index;
                            selectAll = false;
                            // selectedFilter[index] = !selectedFilter[index];

                            // if (selectedLocation.contains(true)) {
                            //   selectedFilter[index] = true;
                            // } else {
                            //   selectedFilter[index] = false;
                            // }
                            // if (selectedOwner.contains(true)) {
                            //   selectedFilter[index] = true;
                            // } else {
                            //   selectedFilter[index] = false;
                            // }
                            // if (selectedDepreciation.contains(true)) {
                            //   selectedFilter[index] = true;
                            // } else {
                            //   selectedFilter[index] = false;
                            // }
                            setState(() {}); //tappedIndex = index
                          },
                          // tileColor: selectedFilter[index] ? Colors.blue : null,
                          title: Text(filterAssets[index],
                              maxLines: 1,
                              style: tappedIndex == index
                                  ? selectedStyle
                                  : unselectedStyle),
                          trailing: tappedIndex == index
                              ? const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 12,
                                )
                              : null,
                        );
                      },
                    ),
                  )
                ])),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CheckboxMenuButton(
                          value: selectAll,
                          onChanged: (value) {
                            if (tappedIndex == 0) {
                              categoryList.forEach((element) {
                                    filterValueCategory.add(element.id);
                              });
                              selectedCategory =
                                  List.filled(categoryList.length, value!);
                            }
                            if (tappedIndex == 1) {
                              selectedLocation =
                                  List.filled(locationList.length, value!);
                              locationList.forEach((element) {
                                filterValueLocation.add(element.id);
                              });
                            }
                            if (tappedIndex == 2) {
                              selectedOwner =
                                  List.filled(ownerList.length, value!);
                              ownerList.forEach((element) {
                                filterValueOwner.add(element.id);
                              });
                            }
                            if (tappedIndex == 3) {
                              selectedDepreciation =
                                  List.filled(depreciationList.length, value!);
                              depreciationList.forEach((element) {
                                filterValueDepreciation.add(element.id);
                              });
                            }
                            selectAll = value!;
                            // selectAllList[tappedIndex] = value!;
                            setState(() {});
                          },
                          child: const Text("Select all")),
                      Expanded(
                          child: tappedIndex == 0
                              ? ListView.separated(
                                  itemCount: categoryList.length,
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        //   if(selectedFilter[0] == false) {
                                        //   if (selectedCategory.contains(true)) {
                                        //     print("object");
                                        //     selectedFilter[0] =
                                        //         !selectedFilter[0];
                                        //   }
                                        // } else {
                                        //     selectedFilter[0] = false;
                                        // }

                                        selectedCategory[index] =
                                            !selectedCategory[index];
                                        if (!filterValueCategory.contains(
                                            categoryList[index]
                                                .id
                                                .toString())) {
                                          filterValueCategory.add(
                                              categoryList[index]
                                                  .id
                                                  .toString());
                                        } else {
                                          filterValueCategory.remove(
                                              categoryList[index]
                                                  .id
                                                  .toString());
                                        }
                                        setState(() {});
                                      },
                                      trailing: selectedCategory[index]
                                          ? const Icon(Icons.check_circle)
                                          : null,
                                      title: Text(categoryList[index].name,
                                          style: selectedCategory[index]
                                              ? selectedStyle
                                              : unselectedStyle),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                        thickness: 1, color: Colors.grey);
                                  },
                                )
                              : tappedIndex == 1
                                  ? ListView.separated(
                                      itemCount: locationList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() =>
                                                selectedLocation[index] =
                                                    !selectedLocation[index]);
                                            if (!filterValueLocation.contains(
                                                locationList[index]
                                                    .id
                                                    .toString())) {
                                              filterValueLocation.add(
                                                  locationList[index]
                                                      .id
                                                      .toString());
                                            } else {
                                              filterValueLocation.remove(
                                                  locationList[index]
                                                      .id
                                                      .toString());
                                            }
                                            // selectLocationItemId.add({
                                            //   "location": locationList[index].id
                                            // });
                                          },
                                          // tileColor: selectedLocation[index]
                                          //     ? Colors.blue
                                          //     : null,
                                          trailing: selectedLocation[index]
                                              ? const Icon(Icons.check_circle)
                                              : null,
                                          title: Text(locationList[index].name,
                                              style: selectedLocation[index]
                                                  ? selectedStyle
                                                  : unselectedStyle),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                            thickness: 1, color: Colors.grey);
                                      },
                                    )
                                  : tappedIndex == 2
                                      ? ListView.separated(
                                          itemCount: ownerList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () {
                                                setState(() =>
                                                    selectedOwner[index] =
                                                        !selectedOwner[index]);
                                                if (!filterValueOwner.contains(
                                                    ownerList[index]
                                                        .id
                                                        .toString())) {
                                                  filterValueOwner.add(
                                                      ownerList[index]
                                                          .id
                                                          .toString());
                                                } else {
                                                  filterValueOwner.remove(
                                                      ownerList[index]
                                                          .id
                                                          .toString());
                                                }
                                              },
                                              // tileColor: selectedOwner[index]
                                              //     ? Colors.blue
                                              //     : null,
                                              trailing: selectedOwner[index]
                                                  ? const Icon(
                                                      Icons.check_circle)
                                                  : null,
                                              title: Text(
                                                  ownerList[index].firstname,
                                                  style: selectedOwner[index]
                                                      ? selectedStyle
                                                      : unselectedStyle),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const Divider(
                                                thickness: 1,
                                                color: Colors.grey);
                                          },
                                        )
                                      : tappedIndex == 3
                                          ? ListView.separated(
                                              itemCount:
                                                  depreciationList.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    setState(() =>
                                                        selectedDepreciation[
                                                                index] =
                                                            !selectedDepreciation[
                                                                index]);
                                                    if (!filterValueDepreciation
                                                        .contains(
                                                            depreciationList[
                                                                    index]
                                                                .id
                                                                .toString())) {
                                                      filterValueDepreciation
                                                          .add(depreciationList[
                                                                  index]
                                                              .id
                                                              .toString());
                                                    } else {
                                                      filterValueDepreciation
                                                          .remove(
                                                              depreciationList[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                    }
                                                  },
                                                  trailing:
                                                      selectedDepreciation[
                                                              index]
                                                          ? const Icon(Icons
                                                              .check_circle)
                                                          : null,
                                                  title: Text(
                                                      depreciationList[index]
                                                          .name,
                                                      style:
                                                          selectedDepreciation[
                                                                  index]
                                                              ? selectedStyle
                                                              : unselectedStyle),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider(
                                                    thickness: 1,
                                                    color: Colors.grey);
                                              },
                                            )
                                          : Container())
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              commonButton(
                  height: 50,
                  width: size.width * .3,
                  onTap: () {
                    bool passIsData = false;
                    if (filterValueCategory.isNotEmpty) {
                      passIsData = true;
                    } else if (filterValueLocation.isNotEmpty) {
                      passIsData = true;
                    } else if (filterValueOwner.isNotEmpty) {
                      passIsData = true;
                    } else if (filterValueDepreciation.isNotEmpty) {
                      passIsData = true;
                    }
                    Navigator.pop(context, passIsData);
                  },
                  context: context,
                  buttonName: "apply",
                  colors: const Color(0xff70ad46)),
              // Expanded(
              //     child: InkWell(
              //         ,
              //         child: Container(
              //           alignment: Alignment.center,
              //           height: 50,
              //           decoration: BoxDecoration(
              //               color: Colors.black26, border: Border.all()),
              //           child: Text("apply".toUpperCase(),
              //               style: const TextStyle(
              //                   color: Colors.blue,
              //                   fontWeight: FontWeight.w500)),
              //         ))),
              commonButton(
                  width: size.width * .3,
                  height: 50,
                  onTap: () => Navigator.pop(context),
                  context: context,
                  buttonName: "close",
                  colors: const Color(0xffd44853))
            ],
          ),
          SizedBox(height: size.height * .01),
        ]),
      ),
    );
  }

  /// Clear filter
  clearAllFilter() {
    selectCategoryItemId.clear();
    filterValueCategory.clear();
    filterValueOwner.clear();
    filterValueLocation.clear();
    filterValueDepreciation.clear();
    selectedCategory = List.filled(categoryList.length, false);
    selectLocationItemId.clear();
    selectedLocation = List.filled(locationList.length, false);
    selectOwnerItemId.clear();
    selectedOwner = List.filled(ownerList.length, false);
    selectDepreciationItemId.clear();
    selectedDepreciation = List.filled(depreciationList.length, false);
    setState(() {});
  }
}
