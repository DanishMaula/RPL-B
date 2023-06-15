import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/utils/helper.dart';

import '../data/model/people.dart';

class PeopleProvider extends ChangeNotifier {
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<People>> getHomePeopleList() async {
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

      People people = People(name: folderName.capitalize(), profileUrl: imageUrl);

      listPeople.add(people);
    }

    listPeople.shuffle();

    return listPeople;
  }
}
