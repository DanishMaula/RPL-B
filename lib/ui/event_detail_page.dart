import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';

import '../common_widget/event_item_list.dart';
import '../data/model/event.dart';
import '../provider/event_provider.dart';

class EventDetailPage extends StatefulWidget {
  final String event;
  static const String routeName = '/event-detail-page';

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
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
        title: Text('Event ${widget.event}'),
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
                type: 'event_image',
                event: widget.event,
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
            const SizedBox(height: 16),
            SizedBox(
              child: Consumer<EventProvider>(
                builder: (context, value, _) {
                  return FutureBuilder(
                    future: value.getDetailEventList(widget.event),
                    builder: (context, snapshot) {
                      if(snapshot.data != null){
                        return MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return EventItemList(
                              event: snapshot.data![index],
                              index: index,
                              length: snapshot.data!.length,
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
