import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/data/model/event.dart';
import 'package:rpl_b/data/model/for_you.dart';
import 'package:rpl_b/data/model/people.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/ui/see_all/see_all_event_page.dart';
import 'package:rpl_b/utils/style_manager.dart';
import '../../common_widget/event_item_item_list.dart';
import '../../common_widget/for_you_item_list.dart';
import '../../common_widget/people_item_list.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<PeopleProvider>(
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
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
                        const SizedBox(
                          width: 45,
                          height: 45,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 36,
                    ),

                    // Events
                    ListWidget(
                      title: "Events",
                      onSeeAllClick: () {
                        Navigator.pushNamed(context, SeeAllEventPage.routeName);
                      },
                      listView: SizedBox(
                        height: 210,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemCount: listEventDummy.length,
                            itemBuilder: (context, index) {
                              return EventItemList(
                                event: listEventDummy[index],
                                index: index,
                                length: listEventDummy.length,
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
                        child: FutureBuilder(
                          future: value.getPeopleList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<People>> snapshot) {
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return PeopleItemList(
                                      people: snapshot.data![index],
                                      index: index,
                                      length: listPeopleDummy.length);
                                });
                          },
                        ),
                      ),
                    ),

                    // For You
                    ListWidget(
                      title: "For you",
                      onSeeAllClick: () {},
                      listView: MasonryGridView.count(
                        shrinkWrap: true,
                        itemCount: listForYouDummy.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ForYouItemList(
                              forYou: listForYouDummy[index], index: index);
                        },
                      ),
                    ),
                  ],
                );
              },
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
