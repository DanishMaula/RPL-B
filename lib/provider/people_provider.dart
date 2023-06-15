import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/people.dart';

class PeopleProvider extends ChangeNotifier {
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<People>> getPeopleList() async {
    List<People> listPeople = [];

    // Get a reference to the parent folder
    Reference parentRef = firebaseStorage.child("people");

    // List all items (files and folders) inside the parent folder
    ListResult result = await parentRef.listAll();

    // Iterate through the result items
    for (var item in result.prefixes) {
      String folderName = item.name;

      listPeople.add(People(name: folderName, profileUrl: await parentRef.child(folderName).child("profile.png").getDownloadURL()));
    }

    return listPeople;
  }
  
}
