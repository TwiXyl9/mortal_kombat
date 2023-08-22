import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerView extends StatelessWidget {
  int maxImages;
  List<XFile?> images;
  Function callback;
  ImagePickerView(this.callback, this.images, this.maxImages);
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: 'photos',
      decoration: const InputDecoration(labelText: 'Photo'),
      maxImages: maxImages,
      initialValue: [images[0]?.path],
      availableImageSources: kIsWeb? const [ImageSourceOption.gallery] : const [ImageSourceOption.gallery, ImageSourceOption.camera],
      validator: (v) {
        if (v!.isEmpty) {
          return 'Choose photo';
        }
      },
      onChanged: (imagePath){
        if(imagePath!.length > 0) callback(imagePath);
      },
    );
  }
}