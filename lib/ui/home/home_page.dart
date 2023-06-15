import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/data/model/event.dart';
import 'package:rpl_b/data/model/memories.dart';
import 'package:rpl_b/data/model/people.dart';
import 'package:rpl_b/provider/event_provider.dart';
import 'package:rpl_b/provider/memories_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/utils/style_manager.dart';

import '../../common_widget/event_item_item_list.dart';
import '../../common_widget/memories_item_list.dart';
import '../../common_widget/people_item_list.dart';
import '../see_all_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                  onSeeAllClick: () {
                    Navigator.pushNamed(context, SeeAllPage.routeName);
                  },
                  listView: SizedBox(
                    height: 210,
                    child: Consumer<EventProvider>(
                      builder: (context, value, _) {
                        return FutureBuilder(
                            future: value.getHomeEventList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Event>> snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return EventItemList(
                                          event: snapshot.data![index],
                                          index: index,
                                          length: snapshot.data!.length);
                                    });
                              }
                            });
                      },
                    ),
                  ),
                ),

                // People
                ListWidget(
                  title: "People",
                  onSeeAllClick: () {},
                  listView: SizedBox(
                    height: 150,
                    child: Consumer<PeopleProvider>(
                      builder: (context, value, _) {
                        return FutureBuilder(
                            future: value.getHomePeopleList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<People>> snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return PeopleItemList(
                                          people: snapshot.data![index],
                                          index: index,
                                          length: snapshot.data!.length);
                                    });
                              }
                            });
                      },
                    ),
                  ),
                ),

                // Memories
                ListWidget(
                    title: "Memories",
                    onSeeAllClick: () {},
                    listView: Consumer<MemoriesProvider>(
                      builder: (context, value, _) {
                        return FutureBuilder(
                          future: value.getHomeMemoriesList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Memories>> snapshot) {
                            return MasonryGridView.count(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length > 10
                                  ? 10
                                  : snapshot.data?.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ForYouItemList(
                                    memories: (snapshot.data ?? listMemoriesDummy)[index],
                                    index: index);
                              },
                            );
                          },
                        );
                      },
                    )),

                SizedBox(
                  height: 24,
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
            GestureDetector(
              onTap: onSeeAllClick,
              child: Text(
                "See all",
                style: getSeeAllTextStyle(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        listView
      ],
    );
  }
}
