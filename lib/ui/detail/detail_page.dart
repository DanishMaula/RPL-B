import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/image_item_list.dart';
import 'package:rpl_b/provider/detail_provider.dart';
import 'package:rpl_b/provider/memories_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';

import '../../provider/event_provider.dart';
import '../../utils/type.dart';

class DetailPage extends StatefulWidget {

  final Map<PhotoType, String> map;

  static const String routeName = '/event-detail-page';

  const DetailPage({Key? key, required this.map,})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    PhotoType type = widget.map.keys.first;
    String title = widget.map.values.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event ${title}'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPhotoPage(
                type: type,
                event: title,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            SizedBox(
              child: Consumer<DetailProvider>(builder: (context, value, _) {
                return FutureBuilder(
                    future: value.getDetailList(title, type),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return MasonryGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ImageItem(
                              imageUrl: snapshot.data![index],
                              index: index,
                              onClick: () {},
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
