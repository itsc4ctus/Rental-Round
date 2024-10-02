import 'package:flutter/material.dart';

class CustomerFeilds{
Widget fields(String? Function(String? value)? validator,String label,String hinttext,TextEditingController controller,[TextInputType keyboardType = TextInputType.text]){
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      hintStyle: const TextStyle(
        fontFamily: 'Roboto',
      ),
      hintText: hinttext,
      label: Text(label,
        style: const TextStyle(
            fontFamily: "Roboto"
        ),
      ),
    ),
  );
}
}