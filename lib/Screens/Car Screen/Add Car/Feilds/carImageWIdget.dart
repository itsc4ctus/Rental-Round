
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class carImageWidget extends StatelessWidget {
  const carImageWidget({
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
                Icons.image,
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

class WebcarImageWidget extends StatelessWidget {
  const WebcarImageWidget({
    super.key,
    required this.carImage,
  });

  final Uint8List? carImage;

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
                Icons.image,
                size: 50,
                color: Colors.grey.shade600,
              )),
        )
            : Image.memory(carImage!,width: 100,height: 100,));
  }
}
