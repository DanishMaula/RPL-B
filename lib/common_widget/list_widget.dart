import 'package:flutter/material.dart';

import '../utils/style_manager.dart';

class ListWidget extends StatelessWidget {
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
