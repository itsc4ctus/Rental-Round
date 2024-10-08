
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCarImage extends StatelessWidget {
  const EditCarImage({
    super.key,
    required this.carImage,
  });

  final XFile? carImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: carImage == null
            ? Container(
          height: 130,
          width: 180,
          color: Colors.grey.shade500,
          child: Center(
              child: Icon(
                CupertinoIcons.creditcard,
                size: 50,
                color: Colors.grey.shade600,
              )),
        )
            : Image(
          image: FileImage(File(carImage!.path)),
          height: 130,
          width: 180,
          fit: BoxFit.cover,
        ));
  }
}
