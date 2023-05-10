import 'package:flutter/material.dart';

import '../utils/const_colors.dart';

class CustomContainer extends StatelessWidget {
  final String labelText;
  String? hintText;
  final BoxDecoration? decoration;
  TextEditingController? editingController;
  Size? size;
  Widget? child;
  double? width;
  Color? color;

      CustomContainer({required this.labelText,this.color,this.width,this.hintText, this.decoration,this.editingController,this.size,this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
        ),
        Positioned(
          bottom: 0,
          child: Container(
              width: width ?? size!.width * .88, height: 50, decoration: decoration, child:  child ?? TextField(
            controller: editingController,
            style: TextStyle(color: textCommonColor),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: textCommonColor),
                prefix: SizedBox(width: 12,),
                border: UnderlineInputBorder(borderSide: BorderSide.none)
            ),
            // onChanged: (value) => radioDialogSelect = value,
          )),
        ),
        Positioned(
          left: 16,
          bottom: 42,
          child: Container(padding: EdgeInsets.symmetric(horizontal: 2),color:color ?? mainBackGroundColor, child: Text(labelText,style: TextStyle(color: textCommonColor),)),
        )
      ],
    );
  }
}