import 'package:assets/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../utils/const_colors.dart';

class Common {
  static loginTextField({
    required String HintText,
    TextEditingController? controller,
    IconData? icon,
    IconData? suffixIcon,
    bool passText = false,
    VoidCallback? onPressed
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 70,
        child: Stack(alignment: Alignment.centerRight, children: [
          SizedBox(
              height: 7.h,
              width: 85.w,
              child: TextField(
                obscureText: passText,
                controller: controller,
                cursorHeight: 24,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    hintText: HintText,
                    hintStyle:
                        TextStyle(color: loginPageBorderColor, fontSize: 18),
                    prefix: const SizedBox(
                      width: 32,
                    ),
                    suffix: IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: loginPageBorderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: loginPageBorderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)))),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    border: loginPageBorder,
                    color: Colors.white,
                    shape: BoxShape.circle),
                child: Icon(color: loginPageBorderColor, size: 28, icon),
              )),
          //CircleAvatar(radius: 35, backgroundColor: Colors.red)
        ]),
      ),
    );
  }

  static Text_field(
      {required String HintText,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: textFieldBackground,
            borderRadius: BorderRadius.circular(10),
            border: commonBorder),
        child: TextField(
          style: commonSelectedStyle,
          controller: controller,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              // contentPadding: const EdgeInsets.only(left: 16),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(icon, color: prefixIconColor),
              ),
              hintText: HintText,
              errorStyle: const TextStyle(fontSize: 10),
              hintStyle: commonHintStyle),
          onChanged: onChanged,
        ),
      ),
    );
  }

  static commonContainer(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      height: 50,
      decoration: BoxDecoration(
          color: textFieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: commonBorder),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.tag,
              color: prefixIconColor,
            ),
          ),
          text == ''
              ? Text("*Tag", style: commonHintStyle)
              : Text(
                  text,
                  style: commonSelectedStyle,
                )
        ],
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
