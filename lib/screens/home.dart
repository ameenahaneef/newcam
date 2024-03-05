import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newcam/screens/gallery.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _imageList = [];

  @override
  void initState() {
    super.initState();
    loadSavedImages();
  }

  Future<void> loadSavedImages() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String imagesPath = '$appDocPath/images';
    List<FileSystemEntity> fileList = Directory(imagesPath).listSync();
    List<File> loadedImages = [];

    for (var file in fileList) {
      if (file is File) {
        loadedImages.add(file);
      }
    }

    setState(() {
      _imageList = loadedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _pickImageFromCamera();
                },
                child: Text('Pick Image From Camera')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GalleryScreen(images: _imageList),
            ),
          );
        },
        child: const Icon(Icons.photo_library),
      ),
    );
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String imagesPath = '$appDocPath/images';
    // print('App Document Directory: $appDocPath');

    if (!(await Directory(imagesPath).exists())) {
      await Directory(imagesPath).create(recursive: true);
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
    File newImage = File(returnedImage.path);
    File newSavedImage = await newImage.copy('$imagesPath/$fileName');

    // print('Image saved at: ${newSavedImage.path}');

    setState(() {
      _imageList.add(newSavedImage);
    });
  }
}
