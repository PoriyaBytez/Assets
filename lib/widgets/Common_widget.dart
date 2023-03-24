import 'package:assets/utils/variables.dart';
import 'package:flutter/material.dart';

class Common {
  static Text_field(
      {required String HintText,
      required TextEditingController controller,
      FormFieldValidator? validator,}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: TextFiel_Background,
            borderRadius: BorderRadius.circular(10),),
        child: TextFormField(
          style: const TextStyle(
            fontSize: 18,
          ),
          controller: controller,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.only(left: 16),
              hintText: HintText,
              errorStyle: TextStyle(fontSize: 10),
              hintStyle:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[850])),
          validator: validator,
        ),
      ),
    );
  }
}
