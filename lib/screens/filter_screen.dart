import 'package:assets/utils/static_fuction.dart';
import 'package:flutter/material.dart';

import '../utils/variables.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int tappedIndex = 0;

  List<String> selectCategoryItemId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("filters".toUpperCase()),
                TextButton(
                    onPressed: () => clearAllFilter(),
                    child: Text("clear all".toUpperCase())),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Column(children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: filterAssets.length,
                    itemBuilder: (context, index) {
                      return /*Container(
                          height: 56,
                          decoration: BoxDecoration(shape: BoxShape.rectangle,color: tappedIndex == index ? Colors.blue : null,),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      setState(() => tappedIndex = index),
                                  child: Text(filterAssets[index],
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 16,)),
                                ),
                                const Icon(Icons.arrow_forward_ios_outlined,
                                    size: 18),
                              ]));*/
                          ListTile(
                        onTap: () {
                          setState(
                              () => tappedIndex = index); //tappedIndex = index
                        },
                        tileColor: tappedIndex == index ? Colors.blue : null,
                        title: Text(filterAssets[index],
                            maxLines: 1, style: TextStyle(fontSize: 14)),
                        // trailing: Icon(Icons.arrow_forward_ios_outlined,size: 12,),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(thickness: 1, color: Colors.grey);
                    },
                  )
                ])),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
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
                                        setState(() => selectedCategory[index] =
                                            !selectedCategory[index]);
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
                                        // selectCategoryItemId.add({
                                        //   "category":
                                        //       categoryList[index].id.toString()
                                        // });
                                        print(
                                            "selectCategoryItemId ==> $filterValueCategory");
                                      },
                                      tileColor: selectedCategory[index]
                                          ? Colors.blue
                                          : null,
                                      title: Text(categoryList[index].name),
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
                                          tileColor: selectedLocation[index]
                                              ? Colors.blue
                                              : null,
                                          title: Text(locationList[index].name),
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
                                              tileColor: selectedOwner[index]
                                                  ? Colors.blue
                                                  : null,
                                              title: Text(
                                                  ownerList[index].firstname),
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
                                                  tileColor:
                                                      selectedDepreciation[
                                                              index]
                                                          ? Colors.blue
                                                          : null,
                                                  title: Text(
                                                      depreciationList[index]
                                                          .name),
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
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close".toUpperCase())),
              TextButton(
                  onPressed: () {
                    bool passIsData = false;
                    if (filterValueCategory.isNotEmpty) {
                      passIsData = true;
                    }else if (filterValueLocation.isNotEmpty) {
                      passIsData = true;
                    }else if (filterValueOwner.isNotEmpty) {
                      passIsData = true;
                    }else if (filterValueDepreciation.isNotEmpty) {
                      passIsData = true;
                    }
                    Navigator.pop(context, passIsData);
                  },
                  child: Text("apply".toUpperCase()))
            ],
          )
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
