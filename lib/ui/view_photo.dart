import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rpl_b/utils/style_manager.dart';

class ViewPhoto extends StatelessWidget {
  static const routeName = '/view_photo';
  const ViewPhoto({super.key, this.imageProvider});

  final ImageProvider<Object>? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // ImageDownloader.downloadImage(imageProvider.toString());
                },
                icon: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                ))
          ],
          elevation: 0,
          backgroundColor: const Color(0x44000000),
          title: Text('View Photo',
              style: getWhiteTextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            PhotoView(
              imageProvider: imageProvider,
            ),
          ],
        ));
  }
}
