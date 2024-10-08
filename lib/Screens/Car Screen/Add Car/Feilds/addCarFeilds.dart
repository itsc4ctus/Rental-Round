import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCarFeilds {
  Widget addCarFeilds(
    String errorMsg,
    String labelName,
    String hintText,
    TextEditingController controller,
      [TextInputType keyboardtype=TextInputType.text,List<TextInputFormatter> textOnly =const [],bool obscureText=false,
      String? Function(String?)? validator,
      ]
      ) {
    return TextFormField(
      validator:validator ?? (value) {
        if (value == null || value == "") {
          return "$errorMsg";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: textOnly,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontFamily: 'Roboto',
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "$hintText",
        label: Text(
          "$labelName",
          style: TextStyle(fontFamily: "Roboto"),
        ),
      ),
    );
  }
  Widget addCarFeildsTwo(
      String errorMsg,
      String labelName,
      TextEditingController controller,
      [TextInputType keyboardtype=TextInputType.text,List<TextInputFormatter> textOnly =const [],bool obscureText=false,
      String? Function(String?)? validator,
      ]
      ) {
    return TextFormField(
      validator:validator?? (value) {
        if (value == null || value == "") {
          return "$errorMsg";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: textOnly,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontFamily: 'Roboto',
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        label: Text(
          "$labelName",
          style: TextStyle(fontFamily: "Roboto"),
        ),
      ),
    );
  }


}
