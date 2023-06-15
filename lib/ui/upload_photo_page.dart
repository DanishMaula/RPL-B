import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/provider/upload_photo_provider.dart';
import 'package:rpl_b/utils/helper.dart';

import '../utils/image_picker_util.dart';
import '../utils/result_state.dart';

class UploadPhotoPage extends StatefulWidget {
  static const routeName = '/upload_photo_page';

  const UploadPhotoPage({Key? key}) : super(key: key);

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? selectedImage;

  void getImageProfile(GetImageFrom source) async {
    final result = await ImagePickerUtil.getImage(source);
    if (result != null) {
      setState(() {
        selectedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UploadPhotoProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GestureDetector(
                onTap: () {
                  buildModalOptionSource(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    image: selectedImage == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                selectedImage!.path,
                              ),
                            ),
                          ),
                  ),
                  child: selectedImage != null
                      ? null
                      : const Center(
                          child: Icon(Icons.add_a_photo),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                color: Colors.redAccent,
                onPressed: () {
                  if (selectedImage == null) {
                    showCustomSnackbar(
                        context, 'No Image Selected', Colors.redAccent);
                    return;
                  }
                  Provider.of<UploadPhotoProvider>(context, listen: false)
                      .uploadImage(selectedImage!)
                      .then(
                        (value) => Navigator.pop(context),
                      );
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<dynamic> buildModalOptionSource(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  getImageProfile(GetImageFrom.camera);
                },
                icon: const Icon(
                  Icons.camera,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  getImageProfile(GetImageFrom.gallery);
                },
                icon: const Icon(
                  Icons.photo,
                  size: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
