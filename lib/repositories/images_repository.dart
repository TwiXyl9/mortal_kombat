
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mortal_combat/general_providers.dart';

import '../models/custom_exception.dart';
import 'characters_repository.dart';

final imagesRepositoryProvider = Provider<ImagesRepository>((ref) => ImagesRepository(ref));

abstract class BaseImagesRepository {
  Future<String> addImage({required XFile image});
  Future<String> updateImage({required oldUrl, required XFile image});
  Future<void> deleteImage({required String imgUrl});
}

class ImagesRepository implements BaseImagesRepository {
  final Ref _ref;

  const ImagesRepository(this._ref);

  @override
  Future<String> addImage({required XFile image}) async {
    try {
      Reference referenceImageToUpload = _ref.read(firebaseStorageProvider).ref().child('images').child(image.name);
      await referenceImageToUpload.putFile(File(image.path));

      return await referenceImageToUpload.getDownloadURL();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> updateImage({required oldUrl, required XFile image}) async {
    try {
      Reference referenceImageToUpload = _ref.read(firebaseStorageProvider).refFromURL(oldUrl);
      await referenceImageToUpload.putFile(File(image.path));

      return await referenceImageToUpload.getDownloadURL();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteImage({required String imgUrl}) async {
    try {

      await _ref.read(firebaseStorageProvider).refFromURL(imgUrl).delete();

    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}