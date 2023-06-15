import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/style_manager.dart';

class EventItemList extends StatelessWidget {
  const EventItemList({
    super.key,
    required this.listEvent,
    required this.index,
  });

  final List<String> listEvent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index != listEvent.length - 1
          ? EdgeInsets.only(right: 16)
          : EdgeInsets.zero,
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
  }
}