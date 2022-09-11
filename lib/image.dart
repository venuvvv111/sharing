// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final imageBytes;
  const ImagePage({Key? key, this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.memory(
          imageBytes,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
