import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/data/model/memories.dart';
import 'package:rpl_b/utils/helper.dart';

import '../utils/result_state.dart';

class MemoriesProvider extends ChangeNotifier {
  String _message = '';

  ResultState _state = ResultState.initialState;

  ResultState get state => _state;

  String get message => _message;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<Memories>> getHomeMemoriesList() async {
    List<Memories> listMemories = [];

    Reference parentRef = firebaseStorage.child("memories");

    ListResult result = await parentRef.listAll();

    for (var item in result.items) {
      String imageUrl;

      try{
        imageUrl = await item.getDownloadURL();
      } catch (e) {
        continue;
      }

      Memories memories =
          Memories(title: item.name.capitalize(), imageUrl: imageUrl);

      listMemories.add(memories);
    }

    // listMemories.shuffle();

    return listMemories;
  }

  Future uploadMemoriesImage(File imageFile, String fileName) async {
    try {
      String imageUrl = '';
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference dirImagesRef = storageRef.child('memories');
      Reference fileRef = dirImagesRef.child(fileName);

      await fileRef.putFile(File(imageFile.path));
      imageUrl = await fileRef.getDownloadURL();
    } on FirebaseException catch (e) {
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
