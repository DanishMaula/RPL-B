import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rpl_b/data/model/memories.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';
import 'package:rpl_b/utils/type.dart';

import '../../common_widget/image_item_list.dart';

class SeeAllMemoriesPage extends StatelessWidget {
  static const routeName = '/see_all_page';
  final List<Memories> listMemories;

  const SeeAllMemoriesPage({Key? key, required this.listMemories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Our Memories'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              UploadPhotoPage.routeName,
              arguments: 'memories',
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.add),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                child: MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  scrollDirection: Axis.vertical,
                  itemCount: listMemories.length,
                  itemBuilder: (context, index) {
                    return ImageItem(
                      imageUrl: listMemories[index].imageUrl,
                      index: index,
                      onClick: (){},
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
