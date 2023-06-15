import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpl_b/data/model/memories.dart';
import 'package:rpl_b/utils/helper.dart';

class MemoriesProvider extends ChangeNotifier{
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<Memories>> getHomeMemoriesList() async {
    List<Memories> listMemories = [];

    Reference parentRef = firebaseStorage.child("memories");

    ListResult result = await parentRef.listAll();

    for (var item in result.items.take(10)) {
      Memories memories = Memories(title: item.name.capitalize(), imageUrl: await item.getDownloadURL());
      listMemories.add(memories);
      print(memories.imageUrl);

    }

    return listMemories;
  }


}