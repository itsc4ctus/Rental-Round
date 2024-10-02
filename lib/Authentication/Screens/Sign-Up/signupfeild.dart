import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpFeilds{
Widget feild(String labeltext,String hinttext,TextEditingController controller,String? Function(String? value)? validator,[TextInputType keyboardtype=TextInputType.text,List<TextInputFormatter> textOnly =const [],bool obscureText=false]  ){
 return TextFormField(
    validator: validator,
   keyboardType: keyboardtype,
inputFormatters: textOnly,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintStyle: const TextStyle(
        fontFamily: 'Roboto',
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)),
      hintText: hinttext,
      label: Text(
        labeltext,
        style: const TextStyle(fontFamily: "Roboto"),
      ),
    ),
  );
}
}