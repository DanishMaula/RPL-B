import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';
import '../../common_widget/event_item_item_list.dart';
import '../../common_widget/text_field_widget.dart';
import '../../data/model/event.dart';

class SeeAllEventPage extends StatefulWidget {
  static const String routeName = '/see-all-event-page';

  const SeeAllEventPage({Key? key}) : super(key: key);

  @override
  State<SeeAllEventPage> createState() => _SeeAllEventPageState();
}

class _SeeAllEventPageState extends State<SeeAllEventPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Event'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadPhotoPage(
                type: 'event', event: 'event kontol',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextfieldWidget(
              hintText: 'Cari Gambar',
              controller: _searchController,
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                scrollDirection: Axis.vertical,
                itemCount: listEventDummy.length,
                itemBuilder: (context, index) {
                  return EventItemList(
                    event: listEventDummy[index],
                    index: index,
                    length: listEventDummy.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
