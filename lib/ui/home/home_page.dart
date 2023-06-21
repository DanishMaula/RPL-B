import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/confirmation_dialog.dart';
import 'package:rpl_b/data/model/memories.dart';
import 'package:rpl_b/provider/event_provider.dart';
import 'package:rpl_b/provider/memories_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/ui/auth/login_page.dart';
import 'package:rpl_b/ui/see_all/see_all_event_page.dart';
import 'package:rpl_b/ui/see_all/see_all_people_page.dart';
import 'package:rpl_b/ui/view_photo.dart';
import 'package:rpl_b/utils/style_manager.dart';
import '../../common_widget/event_item_listt.dart';
import '../../common_widget/image_item_list.dart';
import '../../common_widget/list_widget.dart';
import '../../common_widget/people_item_list.dart';
import '../see_all/see_all_memories_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() async {
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.routeName, (route) => false);
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                                  onLogout: () async {
                                    logout();
                                  },
                                ));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 36,
                ),

                // Events
                Consumer<EventProvider>(builder: (context, value, widget) {
                  return FutureBuilder(
                      future: value.getEventList(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return ListWidget(
                            title: "Events",
                            onSeeAllClick: () {
                              Navigator.pushNamed(
                                  context, SeeAllEventPage.routeName,
                                  arguments: snapshot.data);
                            },
                            listView: SizedBox(
                              height: 210,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length > 5
                                      ? 5
                                      : snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return EventItemList(
                                        event: snapshot.data![index],
                                        index: index,
                                        length: snapshot.data!.length > 5
                                            ? 5
                                            : snapshot.data!.length);
                                  }),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }),

                // People
                Consumer<PeopleProvider>(builder: (context, value, _) {
                  return FutureBuilder(
                      future: value.getPeopleList(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return ListWidget(
                            title: "People",
                            onSeeAllClick: () {
                              Navigator.pushNamed(
                                  context, SeeAllPeoplePage.routeName,
                                  arguments: snapshot.data);
                            },
                            listView: SizedBox(
                                height: 150,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length > 5
                                        ? 5
                                        : snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return PeopleItemList(
                                          people: snapshot.data![index],
                                          index: index,
                                          length: snapshot.data!.length > 5
                                              ? 5
                                              : snapshot.data!.length);
                                    })),
                          );
                        } else {
                          return Container();
                        }
                      });
                }),

                // Memories
                Consumer<MemoriesProvider>(builder: (context, value, _) {
                  return FutureBuilder(
                      future: value.getHomeMemoriesList(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return ListWidget(
                              title: "Memories",
                              onSeeAllClick: () {
                                Navigator.pushNamed(
                                    context, SeeAllMemoriesPage.routeName,
                                    arguments: snapshot.data);
                              },
                              listView: MasonryGridView.count(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length > 10
                                    ? 10
                                    : snapshot.data?.length,
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                itemBuilder: (context, index) {
                                  return ImageItem(
                                      imageUrl: (snapshot.data ??
                                              listMemoriesDummy)[index]
                                          .imageUrl,
                                      index: index,
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context, ViewPhoto.routeName,
                                            arguments: NetworkImage(snapshot
                                                .data![index].imageUrl));
                                      });
                                },
                              ));
                        } else {
                          return Container();
                        }
                      });
                }),

                const SizedBox(
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
