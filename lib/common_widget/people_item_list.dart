import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/people.dart';
import '../utils/style_manager.dart';

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
    return Padding(
      padding: index != length - 1
          ? EdgeInsets.only(right: 16)
          : EdgeInsets.zero,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: FadeInImage.assetNetwork(
              image: people.profileUrl,
              imageErrorBuilder: (a, b, c){
                return Image.asset("assets/images/gray_place_holder.png");
              },
              placeholder: "assets/images/gray_place_holder.png",
            ),
          ),
          SizedBox(height: 16),
          Text(
            people.name,
            style: getBlackTextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}