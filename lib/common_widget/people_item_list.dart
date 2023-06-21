import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../data/model/people.dart';
import '../ui/detail/detail_page.dart';
import '../utils/style_manager.dart';
import '../utils/type.dart';

class PeopleItemList extends StatelessWidget {
  const PeopleItemList({
    super.key,
    required this.length,
    required this.people,
    required this.index,
  });

  final People people;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: { PhotoType.people : people.name.toLowerCase() },

        );
      },
      child: Padding(
        padding:
            index != length - 1 ? EdgeInsets.only(right: 16) : EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipOval(
                child: FadeInImage.memoryNetwork(
                  image: people.profileUrl,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (a, b, c){
                    return Image.asset("assets/images/gray_place_holder.png", fit: BoxFit.cover,);
                  },
                  placeholder: kTransparentImage,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              people.name,
              style: getBlackTextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
