import 'package:assets/utils/variables.dart';
import 'package:assets/widgets/customContainer.dart';
import 'package:flutter/material.dart';

import '../utils/const_colors.dart';
class DropDownWidget extends StatelessWidget {
  
  DropDownWidget({
      required this.showList,
      required this.selectedItem,
      required this.defaultText,
      this.onTap,
     });

  String selectedItem = '';
  String defaultText = '';
  GestureTapCallback? onTap;
  bool showList;
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(children: [
        CustomContainer(
          size: size,
            width: size.width * .95,
            // padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                color: textFieldBackground,
                borderRadius: BorderRadius.circular(10),
                border: commonBorder),
            // height: 50,
            labelText: defaultText.replaceAll("*", ""),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap:onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: Icon(icon,color: prefixIconColor),
                    // ),
                    Expanded(
                      child: selectedItem== '' ? Text(defaultText,style: commonHintStyle,) : Text(selectedItem,style: commonSelectedStyle,)
                    ),
                    Icon(color: iconColor,
                      showList ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      size: 34,
                    ),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 6),
      ]),
    );
  }
}
