import 'dart:io';

import 'package:flutter/material.dart';


class ViewImage extends StatelessWidget {
  String image;
  ViewImage({required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Image(image: FileImage(File(image))),
      ),
    );
  }
}
