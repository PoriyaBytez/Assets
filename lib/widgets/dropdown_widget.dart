import 'package:flutter/material.dart';

import '../utils/variables.dart';
class DropDownWidget extends StatelessWidget {
  
  DropDownWidget({
      required this.showList,
      required this.selectedItem,
      required this.defaultText,
      this.onTap
     });

  String selectedItem = '';
  String defaultText = '';
  GestureTapCallback? onTap;
  bool showList;
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                color: TextFiel_Background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Border_color, width: 2)),
            height: 50,
            child: InkWell(
              onTap:onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedItem=='' ? defaultText : selectedItem,
                      style: const TextStyle(fontSize: 18)),
                  Icon(color: Icon_color,
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
