import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/utils/helper.dart';

import '../data/model/event.dart';

class EventProvider extends ChangeNotifier{
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<Event>> getHomeEventList() async {
    List<Event> listEvent = [];

    Reference parentRef = firebaseStorage.child("event");

    ListResult result = await parentRef.listAll();

    for (var item in result.prefixes.take(5)) {
      String folderName = item.name;

      listEvent.add(Event(title: folderName.capitalize(), imageUrl: await parentRef.child(folderName).child("cover.png").getDownloadURL()));
    }

    return listEvent;
  }

}