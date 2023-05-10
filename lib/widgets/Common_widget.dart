import 'package:assets/utils/variables.dart';
import 'package:assets/widgets/customContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';

import '../utils/const_colors.dart';
import '../utils/static_function.dart';

class Common {
  static loginTextField(
      {required String HintText,
      TextEditingController? controller,
      IconData? suffixIcon,
      bool passText = false,
      VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
          obscureText: passText,
          decoration: InputDecoration(
            labelText: HintText,
            hintText: HintText,
            suffix: InkWell(onTap: onPressed, child: Icon(suffixIcon)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: loginPageBorderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: loginPageBorderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          )),
    );
  }

  static Text_field(
      {required String HintText,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      Size? size}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: CustomContainer(
        decoration: BoxDecoration(
            color: textFieldBackground,
            borderRadius: BorderRadius.circular(10),
            border: commonBorder),
        labelText: HintText.replaceAll("*", ""),
        size: size,
        color: Colors.white,
        width: size!.width * .95,
        child: TextField(
          style: commonSelectedStyle,
          controller: controller,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              prefix: SizedBox(
                width: 8,
              ),
              hintText: HintText,
              errorStyle: const TextStyle(fontSize: 10),
              hintStyle: commonHintStyle),
          onChanged: onChanged,
        ),
      ),
    );
  }

  static DailogText_field({
    required String HintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: textFieldBackground,
            borderRadius: BorderRadius.circular(10),
            border: commonBorder),
        child: TextField(
          keyboardType: keyboardType,
          style: commonSelectedStyle,
          controller: controller,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              prefix: const SizedBox(
                width: 12,
              ),
              hintText: HintText,
              errorStyle: const TextStyle(fontSize: 10),
              hintStyle: commonHintStyle),
        ),
      ),
    );
  }

  static commonContainer({String? text, Size? size}) {
    return CustomContainer(
      // padding: const EdgeInsets.only(left: 16),
      // alignment: Alignment.centerLeft,
      // height: 50,
      decoration: BoxDecoration(
          color: textFieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: commonBorder),
      labelText: 'Tag',
      size: size,
      color: Colors.white,
      width: size!.width * .78,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            text == ''
                ? Text("*Tag", style: commonHintStyle)
                : Text(
                    text!,
                    style: commonSelectedStyle,
                  )
          ],
        ),
      ),
    );
  }

  static commonToastMessage({String? messages, Color? colorBG}) {
    Fluttertoast.showToast(
        msg: messages!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorBG,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static commonSearchTextFieldDropDown(
      {TextEditingController? searchController,
      ValueChanged<String>? onChanged,
      List<dynamic>? search}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 38,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: iconColor)),
            suffixIcon: IconButton(
              onPressed: () {
                searchController!.clear();
                search!.clear();
              },
              icon: Icon(Icons.clear, color: iconColor),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: iconColor,
            ),
            hintText: 'Search'),
        onChanged: onChanged,
      ),
    );
  }
}

showSnackBar(String message, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  ));
}

commonIconBuild({GestureTapCallback? onTap, IconData? icon, String? label}) {
  return InkWell(
      onTap: onTap,
      child: SizedBox(
          // height: 10.h,
          child: Column(children: [
        Icon(icon, size: 32),
        Text(
          label!,
          style: TextStyle(fontSize: 14),
        )
      ])));
}

commonButtonAssetScreen({
  GestureTapCallback? onTap,
  String? imagePath,
  Color? colorBG,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: colorBG, borderRadius: BorderRadius.circular(4)),
          child: Image.asset(
            imagePath!,
            height: 20,
            width: 20,
          ),
        )),
  );
}

commonButtonDetailScreen({
  GestureTapCallback? onTap,
  String? imagePath,
  Color? colorBG,
  Size? size,
  String? title,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: InkWell(
        onTap: onTap,
        child: Container(
            height: 40,
            width: size!.width * .205,
            decoration: BoxDecoration(
                color: colorBG, borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath!,
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: SizedBox(width: size.width * .14,
                    child: Text(title!,
                        overflow: TextOverflow.clip, maxLines: 1),
                  ),
                )
              ],
            ))),
  );
}

bottomSheetTextField({String? labelText}) {
  return TextField(
    decoration: InputDecoration(
        labelText: labelText!,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: commonBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: commonBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: commonBorderColor))),
  );
}

datePickerContainer({
  VoidCallback? onPressed,
  Size? size,
  String? labelText,
  String? hintText,
  String? datePick,
}) {
  return CustomContainer(
    size: size,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: textCommonColor)),
    labelText: labelText!,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: datePick != ''
            ? Text(
                datePick!,
                style: TextStyle(fontSize: 17, color: textCommonColor),
              )
            : Text(
                hintText!,
                style: TextStyle(fontSize: 17, color: textCommonColor),
              ),
      ),
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            size: 25,
            Icons.date_range_outlined,
            color: textCommonColor,
          ))
    ]),
  );
}

detailScreenCommonContainer({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: commonBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$title :",style: TextStyle(color: textCommonColor)),
              Text(value,style: TextStyle(fontSize: 16,color: Color(0xff363f5e)),),
            ],
          ),
        )),
  );
}
