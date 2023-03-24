import 'dart:io';

import 'package:assets/screens/qr_scanner.dart';
import 'package:assets/utils/variables.dart';
import 'package:assets/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../api/api_servies.dart';
import '../api/models/assets_model.dart';
import '../api/models/categary_model.dart';
import '../api/models/depreciation_model.dart';
import '../api/models/location_model.dart';
import '../api/models/owner_model.dart';
import '../api/models/subcategories1_model.dart';
import '../widgets/Common_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final formkey = GlobalKey<FormState>();

  ///image selection
  int pageIndex = 0;
  List<File> fileImage = [];
  final PageController _controller = PageController(initialPage: 0, keepPage: false);

  Assets? assets;

  List<Categary> categoryList = [];
  List<Subcategory> subCategoryList1 = [];
  List<Subcategory_1> subCategoryList2 = [];
  List<Subcategory1> tempSubCategoryList2 = [];
  List<Description> depreciationList = [];
  List<Location> locationList = [];
  List<Owner> ownerList = [];

  bool showListCategory = true;
  bool showListSubCategory1 = true;
  bool showListSubCategory2 = true;
  bool showListLocation = true;
  bool showListStatus = true;
  bool showListDepreciation = true;
  bool showListOwner = true;

  /// for get id
  int categoryId = 0;
  String subCategory1Id = '';
  String subCategory2Id = '';
  String depreciationId = '';
  String locationId = '';
  String ownerId = '';

  /// for show
  String categoryItem ='';
  String subCategoryItem1 = '';
  String subCategoryItem2 = '';
  String depreciationItem = '';
  String locationItem = '';
  String ownerItem = '';
  String tag = '';

  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController searchSubCategory1Controller = TextEditingController();
  TextEditingController searchSubCategory2Controller = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();
  TextEditingController searchStatusController = TextEditingController();
  TextEditingController searchDepreciationController = TextEditingController();
  TextEditingController searchOwnerController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  getCategoriesList() async {
    categoryList = await getCategories();
    setState(() {});
  }

  getSubCategories1([int? id]) async {
    tempSubCategoryList2 = await getSubCategory(id);
     subCategoryList2 =tempSubCategoryList2[0].subcategories;
    setState(() {});
  }

  getLocationCategory() async {
    locationList = await getLocation();
    setState(() {});
  }

  getDepreciationCategory() async {
    depreciationList = await getDescription();
    setState(() {});
  }

  getOwnerCategory() async {
    ownerList = await getOwner();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoriesList();
    getLocationCategory();
    getDepreciationCategory();
    getOwnerCategory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            color: BackGround,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height / 5,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: TextFiel_Background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (pageIndex > 0) {
                                  setState(() {
                                    pageIndex--;
                                  });
                                }
                                _controller.jumpToPage(pageIndex);
                              },
                              icon: const Icon(Icons.chevron_left_outlined)),
                          Expanded(
                            child: InkWell(
                              onTap: () {
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
                              },
                              child: fileImage.length == 0
                                  ? const Icon(Icons.camera_alt_outlined)
                                  : PageView.builder(
                                  controller: _controller,
                                  itemCount: fileImage.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    pageIndex = index;
                                    return Image.file(
                                      fileImage[index],
                                      fit: BoxFit.fill,
                                    );
                                  }),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (pageIndex < fileImage.length - 1) {
                                  setState(() {
                                    pageIndex++;
                                  });
                                }
                                _controller.jumpToPage(pageIndex);
                              },
                              icon: const Icon(Icons.chevron_right_outlined)),
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
                          child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            decoration: BoxDecoration(
                              color: TextFiel_Background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(tag=='' ? 'Tag' : tag,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QRViewScanner(),
                                )).then((value) async {
                              setState(() {
                                tag = value;
                              });
                            });
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 2, color: Border_color)),
                              child: const Icon(size: 40, Icons.qr_code)),
                        ),
                      )),
                    ],
                  ),
                  Common.Text_field(controller: nameController, HintText: 'Name',validator: (value) => formValidateTextField('Name',value),),
                  Common.Text_field(HintText:'Description',controller: descriptionController,validator: (value) => formValidateTextField('Description',value)),

                  /// category list
                  DropDownWidget(
                    showList: showListCategory,
                    selectedItem: categoryItem,
                    defaultText: "Select Category",
                    onTap: () {
                      setState(() {
                        showListCategory = !showListCategory;
                      });
                    },
                  ),
                  showListCategory
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchCategoryController,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchCategoryController.clear();
                                                getCategoriesList();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        onChanged: (value) =>
                                            filterSearchCategory(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: categoryList.length,
                                        itemBuilder: (context, index) {
                                          return showListCategory
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      categoryId = categoryList[index].id;
                                                      subCategoryList1 = categoryList[index].subcategories;
                                                      categoryItem = categoryList[index].name;
                                                      showListCategory = true;
                                                    });
                                                    getSubCategories1(categoryId);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      categoryList[index].name,
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
                            ],
                          ),
                        ),

                  /// subcatogary 1 list
                  DropDownWidget(
                    showList: showListSubCategory1,
                    selectedItem: subCategoryItem1,
                    defaultText: "Select SubCategory 1",
                    onTap: () {
                      if(categoryItem != '') {
                        setState(() {
                          showListSubCategory1 = !showListSubCategory1;
                        });
                      }else {
                        showSnackBar('Please select Category');
                      }
                    },
                  ),
                  showListSubCategory1
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchSubCategory1Controller,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchSubCategory1Controller
                                                    .clear();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        onChanged: (value) =>
                                            filterSearchSubCategory1(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: subCategoryList1.length,
                                        itemBuilder: (context, index) {
                                          return showListSubCategory1
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      subCategory1Id = subCategoryList1[index].id;
                                                      subCategoryItem1 = subCategoryList1[index].name;
                                                      showListSubCategory1 = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      subCategoryList1[index].name,
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
                            ],
                          ),
                        ),

                  /// subcategory 2  list
                  DropDownWidget(
                    showList: showListSubCategory2,
                    selectedItem: subCategoryItem2,
                    defaultText: "Select SubCategory 2",
                    onTap: () {
                      if(subCategoryItem1 != '') {
                        setState(() {
                          showListSubCategory2 = !showListSubCategory2;
                        });
                      }else {
                        showSnackBar('Please select Subcategory 1');
                      }
                    },
                  ),
                  showListSubCategory2
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                // height: showListCategory ? 0 : 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchSubCategory2Controller,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchSubCategory2Controller
                                                    .clear();
                                                getSubCategory();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        // onChanged: (value) =>
                                        //     filterSearchSubCategory2(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: subCategoryList2.length,
                                        itemBuilder: (context, index) {
                                          return showListSubCategory2
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      subCategory2Id = subCategoryList2[index].id;
                                                      subCategoryItem2 = subCategoryList2[index].name;
                                                      showListSubCategory2 = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      subCategoryList2[index]
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
                            ],
                          ),
                        ),

                  /// location list
                  DropDownWidget(
                    showList: showListLocation,
                    selectedItem: locationItem,
                    defaultText: "Select Location",
                    onTap: () {
                      setState(() {
                        showListLocation = !showListLocation;
                      });
                    },
                  ),
                  showListLocation
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchLocationController,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchLocationController.clear();
                                                getLocationCategory();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        onChanged: (value) =>
                                            filterSearchLocation(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: locationList.length,
                                        itemBuilder: (context, index) {
                                          return showListLocation
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      locationId =
                                                          locationList[index].id;
                                                      locationItem =
                                                          locationList[index]
                                                              .name;
                                                      showListLocation = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      locationList[index].name,
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
                            ],
                          ),
                        ),

                  /// depreciation list
                  DropDownWidget(
                    showList: showListDepreciation,
                    selectedItem: depreciationItem,
                    defaultText: "Select Depreciation",
                    onTap: () {
                      setState(() {
                        showListDepreciation = !showListDepreciation;
                      });
                    },
                  ),
                  showListDepreciation
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchDepreciationController,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchDepreciationController
                                                    .clear();
                                                getDescription();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        onChanged: (value) =>
                                            filterSearchDepreciation(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: locationList.length,
                                        itemBuilder: (context, index) {
                                          return showListDepreciation
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      depreciationId =
                                                          depreciationList[index]
                                                              .id;
                                                      depreciationItem =
                                                          depreciationList[index]
                                                              .name;
                                                      showListDepreciation = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      depreciationList[index].name,
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
                            ],
                          ),
                        ),

                  /// owner list
                  DropDownWidget(
                    showList: showListOwner,
                    selectedItem: ownerItem,
                    defaultText: "Select Owner",
                    onTap: () {
                      setState(() {
                        showListOwner = !showListOwner;
                      });
                    },
                  ),
                  showListOwner
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: TextFiel_Background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 38,
                                      child: TextField(
                                        controller: searchOwnerController,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Icon_color)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                searchOwnerController.clear();
                                                getOwner();
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Icon_color),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Icon_color,
                                            ),
                                            hintText: 'Search'),
                                        onChanged: (value) =>
                                            filterSearchOwner(value),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 158,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(left: 22),
                                        itemCount: ownerList.length,
                                        itemBuilder: (context, index) {
                                          return showListOwner
                                              ? null
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ownerId =
                                                          ownerList[index].id;
                                                      ownerItem = ownerList[index]
                                                          .firstname;
                                                      showListOwner = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text(
                                                      ownerList[index].firstname,
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
                            ],
                          ),
                        ),

                  Common.Text_field(HintText:'Acquired Amount', controller:amountController,validator: (value) => formValidateTextField('Acquired Amount',value)),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(color: TextFiel_Background,
                        borderRadius: BorderRadius.circular(10),),
                      child: TextFormField(readOnly: true,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        controller: dateController,
                        decoration:  InputDecoration(
                            border: const UnderlineInputBorder(borderSide: BorderSide.none),
                            prefix: const SizedBox(width: 16,),
                            hintText: 'Acquired Date',
                            errorStyle: const TextStyle(fontSize: 10),
                            suffixIcon: IconButton(
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
                                      dateController.text = formattedDate;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black,
                                )),
                            hintStyle:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[850])),
                        validator: (value) => formValidateTextField('Date',value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()){
                          if (fileImage.length < 2 || fileImage.length > 4) {
                            showSnackBar("Please Don't Select Less Then 2 or More Then 4 Images.");
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       title: const Text(
                            //           "Please Don't Select Less Then 2 or More Then 4 Images."),
                            //       actions: [
                            //         TextButton(
                            //             onPressed: () {
                            //               Navigator.pop(context);
                            //             },
                            //             child: const Text("Ok"))
                            //       ],
                            //     );
                            //   },
                            // );
                          }else if(tag == ''){
                            showSnackBar('Please Scan QR for Tag');
                          }
                          else if(categoryItem==''){
                            showSnackBar('Please select category item');
                          }
                          else if(subCategoryItem1==''){
                            showSnackBar('Please select Subcategory 1 item');
                          }
                          else if(subCategoryItem2==''){
                            showSnackBar('Please select Subcategory 2 item');
                          }
                          else if(locationItem==''){
                            showSnackBar('Please select Location');
                          }
                          else if(depreciationItem==''){
                            showSnackBar('Please select Depreciation');
                          }
                          else if(ownerItem==''){
                            showSnackBar('Please select Owner');
                          } else {
                            postData(
                                tag: tag,
                                date: dateController.text,
                                amount: amountController.text,
                                name: nameController.text,
                                description: descriptionController.text,
                                category: categoryId,
                                subcategory1: subCategory1Id,
                                subcategory2: subCategory2Id,
                                location: locationId,
                                depreciation: depreciationId,
                                owner: ownerId,
                                fileImage: fileImage
                            );
                            print("data is submitted");
                          }
                        }


                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Submit_button,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('Submit',
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
  }

  showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),duration: const Duration(seconds: 2),));
  }


  formValidateTextField(String title,value){
    if (value!.isEmpty) {
      return 'Please Enter Your $title';
    } else {
      return null;
    }
  }

  ///select image
  selectImages(ImageSource source) async {

    final ImagePicker _picker = ImagePicker();

    final result = await _picker.pickImage(source: source);

    if (result != null) {
        final dir = await path_provider.getExternalStorageDirectory();
        int name = DateTime.now().millisecondsSinceEpoch;
        final targetPath = '${dir!.path}/$name.jpg';
        var compressFile = await FlutterImageCompress.compressAndGetFile(
          result.path,
          targetPath,
          minWidth: 372,
          minHeight: 372,
        );
        fileImage.add(File(compressFile!.path));
        print("compressFile ==> ${compressFile.path}");
        print("fileImage ==> ${fileImage[0]}");


      /*if (result.paths.length < 2 || result.paths.length > 4) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                  "Please Don't Select Less Then 2 or More Then 4 Images."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          },
        );
      } else {
        fileImage = result.paths.map((path) => File(path!)).toList();
        print("file length ==> ${fileImage?.length}");
      }*/
      setState(() {});
    } else {
      // User canceled the picker
      print("image not selected...");
    }
  }

  /// Subcategory search filter
  filterSearchCategory(String value) {
    if (searchCategoryController.text.isNotEmpty) {
      categoryList.retainWhere((element) {
        // String search = searchCategoryController.text.toLowerCase();
        String listName = element.name.toLowerCase();
        return listName.contains(value);
      });
    } else {
      getCategoriesList();
    }
    setState(() {});
  }

  /// Subcategory 1 search filter
  filterSearchSubCategory1(String value) {
    if (searchSubCategory1Controller.text.isNotEmpty) {
      subCategoryList1.retainWhere((element) {
        // String search = searchCategoryController.text.toLowerCase();
        String listName = element.name.toLowerCase();
        return listName.contains(value);
      });
    } else {
      getSubCategory();
    }
    setState(() {});
  }

  /// Subcategory2 search filter
  // filterSearchSubCategory2(String value) {
  //   if (searchSubCategory2Controller.text.isNotEmpty) {
  //     subCategoryList2.retainWhere((element) {
  //       // String search = searchCategoryController.text.toLowerCase();
  //       String listName = element.name.toLowerCase();
  //       return listName.contains(value);
  //     });
  //   } else {
  //     getSubCategary();
  //   }
  //   setState(() {});
  // }

  /// Location search filter
  filterSearchLocation(String value) {
    if (searchLocationController.text.isNotEmpty) {
      locationList.retainWhere((element) {
        // String search = searchCategoryController.text.toLowerCase();
        String listName = element.name.toLowerCase();
        return listName.contains(value);
      });
    } else {
      getSubCategory();
    }
    setState(() {});
  }

  /// Depreciation search filter
  filterSearchDepreciation(String value) {
    if (searchDepreciationController.text.isNotEmpty) {
      depreciationList.retainWhere((element) {
        // String search = searchCategoryController.text.toLowerCase();
        String listName = element.name.toLowerCase();
        return listName.contains(value);
      });
    } else {
      getSubCategory();
    }
    setState(() {});
  }

  /// owner search filter
  filterSearchOwner(String value) {
    if (searchOwnerController.text.isNotEmpty) {
      ownerList.retainWhere((element) {
        // String search = searchCategoryController.text.toLowerCase();
        String listName = element.firstname.toLowerCase();
        return listName.contains(value);
      });
    } else {
      getSubCategory();
    }
    setState(() {});
  }
}
