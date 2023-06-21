import 'package:flutter/material.dart';
import 'package:rpl_b/data/model/event.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/style_manager.dart';

class SeeAllEventItem extends StatelessWidget {
  const SeeAllEventItem(
      {super.key,
      required this.event,
      required this.index,
      required this.length});

  final Event event;
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
                  image: event.imageUrl,
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
              child: Text(event.title,
                  textAlign: TextAlign.center,
                  style: getWhiteTextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
