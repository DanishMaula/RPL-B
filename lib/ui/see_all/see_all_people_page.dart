import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rpl_b/common_widget/people_item_list.dart';

import '../../common_widget/text_field_widget.dart';
import '../../data/model/people.dart';
import '../upload_photo_page.dart';

class SeeAllPeoplePage extends StatefulWidget {
  static const String routeName = '/see-all-people-page';
  final Future<List<People>> listPeople;

  const SeeAllPeoplePage({Key? key, required this.listPeople})
      : super(key: key);

  @override
  State<SeeAllPeoplePage> createState() => _SeeAllPeoplePageState();
}

class _SeeAllPeoplePageState extends State<SeeAllPeoplePage> {

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
        title: const Text('All People'),
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            TextfieldWidget(
              hintText: 'Cari Orang',
              controller: _searchController,
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: FutureBuilder(
                  future: widget.listPeople,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return PeopleItemList(
                            people: snapshot.data![index],
                            index: index,
                            length: snapshot.data!.length,
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
    ;
  }
}
