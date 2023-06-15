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

    for (var item in result.prefixes.take(5)) {
      String folderName = item.name;

      listPeople.add(People(name: folderName.capitalize(), profileUrl: await parentRef.child(folderName).child("profile.png").getDownloadURL()));
    }

    return listPeople;
  }
  
}
