import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

XFile? _images;
List<String>? _imageBytes = [];
Future pickMultipleImages() async {
  final List<XFile>? images =
      await ImagePicker().pickMultiImage(imageQuality: 100);
  if (images == null) {
    return;
  }
  print(images.toString());
}

// Future<void> loadAssets() async {
//   List<Asset> images = <Asset>[];
//   String _error = 'No Error Dectected';
//   List<Asset> resultList = <Asset>[];
//   String error = 'No Error Detected';

//   try {
//     resultList = await MultiImagePicker.pickImages(
//       maxImages: 3,
//       enableCamera: true,
//       selectedAssets: images,
//       cupertinoOptions: CupertinoOptions(
//         takePhotoIcon: "chat",
//         doneButtonTitle: "Fatto",
//       ),
//       materialOptions: MaterialOptions(
//         actionBarColor: "#abcdef",
//         actionBarTitle: "Example App",
//         allViewTitle: "All Photos",
//         useDetailsView: false,
//         selectCircleStrokeColor: "#000000",
//       ),
//     );
//   } on Exception catch (e) {
//     error = e.toString();
//   }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  // if (!mounted) return;

  // setState(() {
  //   images = resultList;
  //   _error = error;
  // });

