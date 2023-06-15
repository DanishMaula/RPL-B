import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  final int index;
  const ImageCardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: (index % 5 + 1) * 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
