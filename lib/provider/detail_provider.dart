import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../utils/type.dart';

class DetailProvider extends ChangeNotifier {
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<String>> getDetailList(String title, PhotoType type) async {
    List<String> list = [];

    Reference parentRef = firebaseStorage.child(type.name).child(title);

    ListResult result = await parentRef.listAll();

    for (var item in result.items) {

      String imageUrl;
      try {
        imageUrl = await item.getDownloadURL();
      } catch (e) {
        continue;
      }
      list.add(imageUrl);
    }

    list.shuffle();

    return list;
  }
}
