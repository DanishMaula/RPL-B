import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForYouItemList extends StatelessWidget {
  const ForYouItemList({
    super.key, required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: (index % 5 + 1) * 100,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15)));
  }
}