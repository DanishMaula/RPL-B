import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../data/model/memories.dart';

class ForYouItemList extends StatelessWidget {
  const ForYouItemList({
    super.key,
    required this.index,
    required this.memories,
  });

  final int index;
  final Memories memories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage.memoryNetwork(
            image: memories.imageUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (a, b, c) {
              return Image.asset("assets/images/gray_place_holder.png",
                  fit: BoxFit.cover);
            },
            placeholder: kTransparentImage,
          ),
        ),
      ],
    );
  }
}
