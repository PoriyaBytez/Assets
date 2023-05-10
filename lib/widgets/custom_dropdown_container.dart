import 'package:flutter/material.dart';

import '../utils/const_colors.dart';

class CustomDropDownContainer extends StatelessWidget {
  final String labelText;
  String? hintText;
  final BoxDecoration? decoration;
  TextEditingController? editingController;
  Size? size;
  Widget? child;
  double? width;
  Color? color;

  CustomDropDownContainer({required this.labelText,this.color,this.width,this.hintText, this.decoration,this.editingController,this.size,this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: size!.height * .25,
        ),
        Positioned(
          bottom: 0,
          child: Container(
              width: width ?? size!.width * .88, height: size!.height * .25, decoration: decoration, child:  child ?? TextField(
            controller: editingController,
            style: TextStyle(color: textCommonColor),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: textCommonColor),
                prefix: const SizedBox(width: 12),
                border: const UnderlineInputBorder(borderSide: BorderSide.none)
            ),
            // onChanged: (value) => radioDialogSelect = value,
          )),
        ),
        Positioned(
          left: 16,
          bottom: size!.height * .25 - 10,
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 2),color:color ?? mainBackGroundColor, child: Text(labelText,style: TextStyle(color: textCommonColor),)),
        )
      ],
    );
  }
}