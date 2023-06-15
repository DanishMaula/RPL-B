import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpl_b/utils/result_state.dart';

class UploadPhotoProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  String _message = '';

  ResultState _state = ResultState.initialState;

  ResultState get state => _state;

  String get message => _message;

  Future uploadImage(File imageFile) async {
    try {
      String imageUrl = '';
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference dirImagesRef = storageRef.child('images');

      Reference fileRef = dirImagesRef.child(uniqueFileName);

      await fileRef.putFile(File(imageFile.path));
      imageUrl = await fileRef.getDownloadURL();
      print(imageUrl);
    } on FirebaseAuthException catch (e) {
      _state = ResultState.error;
      _message = e.message!;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
