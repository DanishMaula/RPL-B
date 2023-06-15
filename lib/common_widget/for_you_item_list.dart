import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/for_you.dart';

class ForYouItemList extends StatelessWidget {
  const ForYouItemList({
    super.key, required this.index, required this.forYou,
  });

  final int index;
  final ForYou forYou;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: [160, 120, 140, 180, 200][index].toDouble(),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15)),
    child: FadeInImage.assetNetwork(
    image: forYou.imageUrl,
      imageErrorBuilder: (a, b, c){
        return Image.asset("assets/images/gray_place_holder.png");
      },
    placeholder: "assets/images/gray_place_holder.png",
    ));
  }
}