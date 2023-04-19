import 'package:assets/utils/variables.dart';
import 'package:flutter/material.dart';

import '../utils/const_colors.dart';
class DropDownWidget extends StatelessWidget {
  
  DropDownWidget({
      required this.showList,
      required this.selectedItem,
      required this.defaultText,
      this.onTap,
      this.icon
     });

  String selectedItem = '';
  String defaultText = '';
  GestureTapCallback? onTap;
  bool showList;
  IconData? icon;
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                color: textFieldBackground,
                borderRadius: BorderRadius.circular(10),
                border: commonBorder),
            height: 50,
            child: InkWell(
              onTap:onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon,color: prefixIconColor),
                  ),
                  Expanded(
                    child: selectedItem== '' ? Text(defaultText,style: commonHintStyle,) : Text(selectedItem,style: commonSelectedStyle,)

                  ),
                  Icon(color: iconColor,
                    showList ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    size: 34,
                  ),
                ],
              ),
            )),
        const SizedBox(height: 6),
      ]),
    );
  }
}
