import 'dart:io';

import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<File> images;
  const GalleryScreen({Key? key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: images.isEmpty
          ? Center(
              child: Text('No images'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(images[index].path),
                  key:ValueKey(images[index].path),
                );
              }),
    );
  }
}
