import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rpl_b/utils/style_manager.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listEvent = ["Edurace", "Mukashi", "Cooking"];
    List<String> listPeople = ["Reihan", "Miqdad", "Danish", "Rafif"];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                // Header
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Miqmeq",
                          style: getBlackTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "For RPL B Exhibition",
                          style: getBlackTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 45,
                      height: 45,
                    ),
                  ],
                ),

                SizedBox(
                  height: 36,
                ),

                // Events
                ListWidget(
                  title: "Events",
                  onSeeAllClick: () {},
                  listView: SizedBox(
                    height: 210,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemCount: listEvent.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index != listPeople.length - 1
                                ? EdgeInsets.only(right: 16)
                                : EdgeInsets.zero,
                            child: Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                SizedBox(
                                  height: 16,
                                  width: 10,
                                ),
                                Text(
                                  listEvent[index],
                                  style: getBlackTextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                // People
                ListWidget(
                  title: "People",
                  onSeeAllClick: () {},
                  listView: SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemCount: listPeople.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index != listPeople.length - 1
                                ? EdgeInsets.only(right: 16)
                                : EdgeInsets.zero,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  listPeople[index],
                                  style: getBlackTextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                // For You
                ListWidget(
                  title: "For you",
                  onSeeAllClick: () {},
                  listView: MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: 5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          width: 100,
                          height: (index % 5 + 1) * 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListWidget<T> extends StatelessWidget {
  final String title;
  final void Function()? onSeeAllClick;
  final Widget listView;

  const ListWidget({
    super.key,
    required this.title,
    this.onSeeAllClick,
    required this.listView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: getTitleTextStyle(fontWeight: FontWeight.w600),
            ),
            Text("See all", style: getSeeAllTextStyle()),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        listView
      ],
    );
  }
}
