import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/utils/helper.dart';

import '../data/model/event.dart';
import '../utils/result_state.dart';

class EventProvider extends ChangeNotifier {
  String _message = '';

  ResultState _state = ResultState.initialState;

  ResultState get state => _state;

  String get message => _message;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<Event>> getHomeEventList() async {
    List<Event> listEvent = [];

    Reference parentRef = firebaseStorage.child("event");

    ListResult result = await parentRef.listAll();

    for (var item in result.prefixes.take(5)) {
      String folderName = item.name;

      listEvent.add(Event(
          title: folderName.capitalize(),
          imageUrl: await parentRef
              .child(folderName)
              .child("cover.png")
              .getDownloadURL()));
    }

    return listEvent;
  }

  Future uploadEventImage(File imageFile, String event, String fileName) async {
    try {
      String imageUrl = '';
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference dirImagesRef = storageRef.child('event').child(event.toLowerCase());
      Reference fileRef = dirImagesRef.child('$fileName.png');
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

  Future uploadEvent(File imageFile, String event) async {
    try {
      String imageUrl = '';
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference dirImagesRef = storageRef.child('event').child(event.toLowerCase());
      Reference fileRef = dirImagesRef.child('cover.png');
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
