import 'package:assets/widgets/Common_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/models/category_post_modul.dart';
import '../api/models/service_get_modul.dart';
import '../api/models/serviece_post_modul.dart';
import '../api/servies/api_servies.dart';
import '../utils/const_colors.dart';
import '../utils/static_function.dart';
import 'customContainer.dart';

TextStyle commonInformationText =
    const TextStyle(fontSize: 16, color: Colors.black);
TextStyle titleText = const TextStyle(
    fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600);
TextStyle informationTextDate =
    const TextStyle(fontSize: 16, color: Colors.blueGrey);

String datePick = '';
String returnDatePick = '';
String radioDialogSelect = "Annual Service".toLowerCase(); //Annual Service

TextEditingController tagServiceController = TextEditingController();
TextEditingController checkInDetailsController = TextEditingController();
TextEditingController checkOutController = TextEditingController();
TextEditingController checkOutDetailsController = TextEditingController();

serviceReminder({
  context,
  Widget? widgets,
  String? title,
  String? details,
  String? serviceDate,
  String? detailsHint,
  Size? sizes,
  String? assetId,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        color: mainBackGroundColor,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Material(
              color: mainBackGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22)),
                  SizedBox(height: sizes!.height * .02),
                  CustomContainer(
                    editingController: tagServiceController,
                    labelText: "Tag",
                    hintText: "Enter Tag",
                    size: sizes,
                    decoration: BoxDecoration(
                        border: Border.all(color: commonBorderColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: sizes.height * .02),
                  CustomContainer(
                    editingController: checkInDetailsController,
                    labelText: "Details",
                    hintText: "Check pressure and gauge function",
                    size: sizes,
                    decoration: BoxDecoration(
                        border: Border.all(color: commonBorderColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: sizes.height * .02),
                  datePickerContainer(
                      datePick: datePick,
                      hintText: "Acquired Date",
                      labelText: "Service date",
                      size: sizes,
                      onPressed: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100)) as DateTime;
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            datePick = formattedDate;
                          });
                        }
                      }),
                  Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commonButton(
                            onTap: () => Navigator.pop(context),
                            colors: Colors.red,
                            buttonName: " cancel ",
                            context: context),
                        commonButton(
                            onTap: () async {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => serviceReminderReturn(
                                      assetId: assetId,
                                      sizes: sizes,
                                      context: context));
                              print("object ==> $radioDialogSelect");
                              // showDialog(context: context, builder: serviceReminderReturn(context: context,sizes: sizes));
                            },
                            buttonName: ' Confirm ',
                            colors: Colors.green,
                            context: context),
                      ])
                ],
              ),
            )),
      );
    },
  );
}

serviceReminderReturn({String? assetId, context, required Size sizes}) {
  return Container(
    color: mainBackGroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Check Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22)),
              Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: RadioMenuButton(
                      value: "Annual Service",
                      groupValue: radioDialogSelect,
                      onChanged: (value) =>
                          setState(() => radioDialogSelect = value!),
                      child: Text("Annual Service",
                          style: TextStyle(color: textCommonColor)))),
              Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: RadioMenuButton(
                      value: "other",
                      groupValue: radioDialogSelect,
                      onChanged: (value) =>
                          setState(() => radioDialogSelect = value!),
                      child: Text("Other",
                          style: TextStyle(color: textCommonColor)))),
              SizedBox(height: sizes.height * .02),
              SizedBox(height: sizes.height * .02),
              CustomContainer(
                editingController: checkOutDetailsController,
                labelText: "Please give details of check out",
                hintText: "Write your Check-Out",
                size: sizes,
                decoration: BoxDecoration(
                    border: Border.all(color: commonBorderColor),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: sizes.height * .02),
              datePickerContainer(
                  datePick: returnDatePick,
                  hintText: "Return Date",
                  labelText: "Expected return date",
                  size: sizes,
                  onPressed: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)) as DateTime;
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        returnDatePick = formattedDate;
                      });
                    }
                  }),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                commonButton(
                    onTap: () => Navigator.pop(context),
                    colors: Colors.red,
                    buttonName: " cancel ",
                    context: context),
                commonButton(
                    onTap: () async {
                      if (tagServiceController.text.isEmpty) {
                        Common.commonToastMessage(
                            messages: "Please Enter Tag",
                            colorBG: Colors.black);
                      } else if (checkInDetailsController.text.isEmpty) {
                        Common.commonToastMessage(
                            messages: "Please Enter Details",
                            colorBG: Colors.black);
                      } else {
                        ServiceGet data = ServiceGet(
                            asset: assetId.toString(),
                            commentOut: checkInDetailsController.text,
                            dateOut: datePick,
                            dateIn: returnDatePick,
                            commentIn: checkOutDetailsController.text,
                            tag: tagServiceController.text);
                        print("object data ==> ${data.dateIn}");
                        serviceReminderPost(data).then((value) {
                          print("value ==> $value");
                          if (value == true) {
                            Common.commonToastMessage(
                                messages: "Successful to Set Service Reminder",
                                colorBG: Colors.black);
                            Navigator.pop(context);
                            checkInDetailsController.clear();
                            tagServiceController.clear();
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => informationDialog(sizes: sizes,context: context)
                            );
                          } else {
                            Common.commonToastMessage(
                                messages:
                                    "Unsuccessful to Set Service Reminder",
                                colorBG: Colors.red);
                          }
                        });
                      }
                      print("object ==> $radioDialogSelect");
                      // showDialog(context: context, builder: serviceReminderReturn(context: context,sizes: sizes));
                    },
                    buttonName: ' Confirm ',
                    colors: Colors.green,
                    context: context),
              ]),
            ],
          );
        },
      ),
    ),
  );
  // : informationDialog(
  // context: context,
  // sizes: sizes,
  // checkOutDate: checkOutDate,
  // expectedReturnDate: expectedReturnDate),
}

informationDialog({
  context,
  Size? sizes,
  String? checkOutDate,
  String? expectedReturnDate,
  String? assetId,
}) {
  // return Container();
  return Container(
    decoration: BoxDecoration(
      color: mainBackGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Information",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22)),
        const SizedBox(height: 30),
        CustomContainer(
          labelText: "Checked out date",
          size: sizes,
          decoration: BoxDecoration(
              border: Border.all(color: commonBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 8),
            child: Text(datePick,style: TextStyle(color: textCommonColor,fontSize: 20)),
          ),
        ),
        SizedBox(height: sizes!.height * .01),

        CustomContainer(
          labelText: "Checked out by",
          size: sizes,
          decoration: BoxDecoration(
              border: Border.all(color: commonBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 8),
            child: Text("Name",style: TextStyle(color: textCommonColor,fontSize: 20)),
          ),
        ),
        SizedBox(height: sizes.height * .01),

        CustomContainer(
          labelText: "Comment",
          size: sizes,
          decoration: BoxDecoration(
              border: Border.all(color: commonBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 8),
            child: Text(checkInDetailsController.text,style: TextStyle(color: textCommonColor,fontSize: 20)),
          ),
        ),
        SizedBox(height: sizes.height * .01),

        CustomContainer(
          labelText: "Expected return date",
          size: sizes,
          decoration: BoxDecoration(
              border: Border.all(color: commonBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 8),
            child: Text(returnDatePick,style: TextStyle(color: textCommonColor,fontSize: 20)),
          ),
        ),
        SizedBox(height: sizes.height * .01),
        const Spacer(),
        commonButton(
            context: context,
            onTap: () {
              tagServiceController.clear();
              checkInDetailsController.clear();
              checkOutController.clear();
              checkOutDate = '';
              expectedReturnDate = '';
              Navigator.pop(context);
            },
            colors: Colors.green,
            buttonName: "confirm")
      ]),
    ),
  );
}

decommissionDialog({context, Size? sizes}) {
  return Container(
    color: mainBackGroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        const Center(child: Text("Decommission", style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w500))),
        SizedBox(height: sizes!.height * .04),
         Text(" This will remove the asset from \n the asset register",
            style: TextStyle(fontSize: 16,color: textCommonColor,fontWeight: FontWeight.w500)),
        SizedBox(height: sizes.height * .04),
        Image.asset("asset/decommision.png",height: sizes.height *.2,width: sizes.width * .3,),
        Spacer(),
        singleCommonButton(
            buttonName: "confirm",
            colors: Colors.green[600],
            onTap: () => Navigator.pop(context),
            context: context)
      ]),
    ),
  );
}

checkInDialog({context, Size? sizes}) {
  return Container(
    color: mainBackGroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text("Check-in", style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w500))),
            SizedBox(height: sizes!.height * .07),
            Text("Please confirm that asset back \n in location",
                style: TextStyle(fontSize: 16,color: textCommonColor,fontWeight: FontWeight.w500)),
            Image.asset("asset/check-in.png",height: sizes.height *.2,width: sizes.width * .3,),
            Spacer(),
            singleCommonButton(
                buttonName: "confirm",
                colors: Colors.green[600],
                onTap: () => Navigator.pop(context),
                context: context)
          ]),
    ),
  );
}

TextEditingController newCategoryNameController = TextEditingController();
TextEditingController newDescriptionController = TextEditingController();

///Add new category
createNewCategoryDialog({Size? sizes, context}) {
  return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: sizes!.width / 10, vertical: sizes.height / 4.1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 2, color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Material(
            child: Column(children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.cancel)),
                  )
                ],
              ),
              const Text("Add New Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Common.DailogText_field(
                  HintText: "Name", controller: newCategoryNameController),
              Common.DailogText_field(
                  HintText: "Description",
                  controller: newDescriptionController),
              Padding(
                padding: const EdgeInsets.all(8),
                child: commonButton(
                    onTap: () {
                      if (newCategoryNameController.text.isEmpty) {
                        showSnackBar('Please Enter Name', context);
                      } else if (newDescriptionController.text.isEmpty) {
                        showSnackBar('Please Enter Description', context);
                      } else {
                        CategoryPost dataPost = CategoryPost(
                          name: newCategoryNameController.text,
                          description: newDescriptionController.text,
                        );
                        createNewCategory(dataPost).then((value) {
                          if (value) {
                            Common.commonToastMessage(
                                messages: "Successful to Add",
                                colorBG: Colors.black);
                          } else {
                            Common.commonToastMessage(
                                messages: "Unsuccessful to Add",
                                colorBG: Colors.red);
                          }
                        });
                      }

                      Navigator.pop(context);
                    },
                    buttonName: "Add",
                    context: context,
                    colors: Colors.greenAccent),
              )
            ]),
          ),
        ),
      ));
}

//==================================================== button =====================================================
commonButton(
    {GestureTapCallback? onTap, Color? colors, String? buttonName, context,double? height,double? width}) {
  var sizes = MediaQuery.of(context).size;
  return InkWell(
    onTap: onTap,
    child: Container(
      height:height ?? sizes.height / 20,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: colors,
      ),
      child: Center(
        child: Text(buttonName!.toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22)),
      ),
    ),
  );
}

singleCommonButton(
    {GestureTapCallback? onTap, Color? colors, String? buttonName, context}) {
  var sizes = MediaQuery.of(context).size;
  return InkWell(
    onTap: onTap,
    child: Container(
      height: sizes.height / 20,
      width: sizes.width / 3.4,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: colors,
      ),
      child: Center(
        child: Text(buttonName!.toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22)),
      ),
    ),
  );
}
