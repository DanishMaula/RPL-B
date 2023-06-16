import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatelessWidget {
  static const routeName = '/view_photo';
  const ViewPhoto({super.key, this.imageProvider});

  final ImageProvider<Object>? imageProvider;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider,
    );
  }
}
