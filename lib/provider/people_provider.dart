import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/utils/helper.dart';

import '../data/model/people.dart';
import '../utils/result_state.dart';

class PeopleProvider extends ChangeNotifier {
  String _message = '';

  ResultState _state = ResultState.initialState;

  ResultState get state => _state;

  String get message => _message;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<People>> getPeopleList() async {
    List<People> listPeople = [];

    Reference parentRef = firebaseStorage.child("people");

    ListResult result = await parentRef.listAll();

    for (var item in result.prefixes) {
      String folderName = item.name;
      String imageUrl;

      try {
        imageUrl = await parentRef
            .child(folderName)
            .child("profile.png")
            .getDownloadURL();
      } catch (e) {
        continue;
      }

      People people =
          People(name: folderName.capitalize(), profileUrl: imageUrl);

      listPeople.add(people);
    }

    listPeople.shuffle();

    return listPeople;
  }

  Future uploadPeopleImage(
      File imageFile, String people, String fileName) async {
    try {
      String imageUrl = '';
      Reference dirImagesRef = firebaseStorage.child('people').child(people);
      // print("File exists ${dirImagesRef.child(fileName)}");
      // if(dirImagesRef.child(fileName)==true){
      Reference fileRef = dirImagesRef.child(fileName);
      await fileRef.putFile(File(imageFile.path));
      imageUrl = await fileRef.getDownloadURL();
      // }else{
      //   _state = ResultState.error;
      //   _message = 'Name is already taken';
      //   notifyListeners();
      // }

      print(imageUrl);
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
