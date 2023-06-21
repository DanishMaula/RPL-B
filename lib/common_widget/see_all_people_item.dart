import 'package:flutter/material.dart';
import 'package:rpl_b/utils/style_manager.dart';
import 'package:transparent_image/transparent_image.dart';

import '../data/model/people.dart';

class SeeAllPeopleItem extends StatelessWidget {
  const SeeAllPeopleItem(
      {super.key,
      required this.people,
      required this.index,
      required this.length});

  final People people;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.memoryNetwork(
                  image: people.profileUrl,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (a, b, c) {
                    return Image.asset(
                      "assets/images/gray_place_holder.png",
                      fit: BoxFit.cover,
                    );
                  },
                  placeholder: kTransparentImage,
                ),
              )),
          // make a text bottom center
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(people.name,
                  textAlign: TextAlign.center,
                  style: getWhiteTextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
