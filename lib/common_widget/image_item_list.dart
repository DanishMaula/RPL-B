import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../data/model/memories.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.onClick,
  });

  final int index;
  final String imageUrl;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage.memoryNetwork(
              image: imageUrl,
              fit: BoxFit.cover,
              imageErrorBuilder: (a, b, c) {
                return Image.asset("assets/images/gray_place_holder.png",
                    fit: BoxFit.cover);
              },
              placeholder: kTransparentImage,
            ),
          ),
        ],
      ),
    );
  }
}
