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

    bool paddingB = false;

    return Scaffold(
      body: SafeArea(
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
              Expanded(
                flex: 2,
                child: ListWidget(
                  title: "Events",
                  onSeeAllClick: () {},
                  listView: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listEvent.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index != listPeople.length - 1 ? EdgeInsets.only(right: 16) : EdgeInsets.zero,
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
              Expanded(
                flex: 2,
                child: ListWidget(
                  title: "People",
                  onSeeAllClick: () {},
                  listView: ListView.builder(
                    padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listPeople.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index != listPeople.length - 1 ? EdgeInsets.only(right: 16) : EdgeInsets.zero,
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
              Expanded(
                child: ListWidget(
                  title: "For you",
                  onSeeAllClick: () {},
                  listView: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListWidget<T> extends StatelessWidget {
  final String title;
  final void Function()? onSeeAllClick;
  final BoxScrollView listView;

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
        Expanded(child: listView)
      ],
    );
  }
}
