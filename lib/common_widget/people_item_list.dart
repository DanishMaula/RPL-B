import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/style_manager.dart';

class PeopleItemList extends StatelessWidget {
  const PeopleItemList({
    super.key,
    required this.listPeople,
    required this.index,

  });

  final List<String> listPeople;
  final int index;

  @override
  Widget build(BuildContext context) {
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
  }
}