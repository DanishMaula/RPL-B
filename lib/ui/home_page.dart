import 'package:flutter/material.dart';
import 'package:rpl_b/utils/style_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [

        // Header

        Row(
          children: [
            Column(
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
              child: Image.asset(""),
            ),
          ],
        ),

        // Events
        ListWidget(
          title: "Events",
          onSeeAllClick: (){},
          listView: ListView(),
        ),

        // People
        ListWidget(
          title: "People",
          onSeeAllClick: (){},
          listView: ListView(),
        ),

        // For You
        ListWidget(
          title: "For you",
          onSeeAllClick: (){},
          listView: ListView(),
        ),
      ],
    ));
  }
}

class ListWidget<T> extends StatelessWidget {
  final String title;
  final void Function()? onSeeAllClick;
  final BoxScrollView listView;
  

  const ListWidget({
    super.key, required this.title, this.onSeeAllClick, required this.listView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Miqmeq",
              style: getTitleTextStyle(),
            ),
            Text(
              "See all",
              style: getSeeAllTextStyle()
            ),
          ],
        ),
        listView
      ],
    );
  }
}


