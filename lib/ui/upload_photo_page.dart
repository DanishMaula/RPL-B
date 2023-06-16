import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/provider/detail_provider.dart';
import 'package:rpl_b/provider/event_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/utils/helper.dart';
import '../common_widget/text_field_widget.dart';
import '../provider/memories_provider.dart';
import '../utils/image_picker_util.dart';
import '../utils/type.dart';

class UploadPhotoPage extends StatefulWidget {
  final PhotoType type;

  final String name;
  static const routeName = '/upload_photo_page';

  const UploadPhotoPage({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  TextEditingController photoNameController = TextEditingController();

  File? selectedImage;

  void getImageProfile(GetImageFrom source) async {
    final result = await ImagePickerUtil.getImage(source);
    if (result != null) {
      setState(() {
        selectedImage = File(result.path);
      });
    }
  }

  void typeValidate() {
    if (widget.type == PhotoType.people) {

      Provider.of<PeopleProvider>(context, listen: false)
          .uploadPeopleImage(selectedImage!, widget.name, photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    } else if (widget.type == PhotoType.event) {
      Provider.of<EventProvider>(context, listen: false)
          .uploadEvent(
              selectedImage!, widget.name, photoNameController.text)
          .then(
            (value)  {
              Navigator.pop(context);
            },
          );
    } else if (widget.type == PhotoType.eventAlbum) {
      Provider.of<EventProvider>(context, listen: false)
          .uploadEventAlbum(selectedImage!, photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    } else {
      Provider.of<MemoriesProvider>(context, listen: false)
          .uploadMemoriesImage(selectedImage!, photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    }
  }

  @override
  void dispose() {
    photoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            // if type is memories then remove textfield
            TextfieldWidget(
              hintText: widget.type == 'event' ? 'Event Name' : 'Photo Name ',
              controller: photoNameController,
              prefixIcon: const Icon(Icons.image),
            ),
            ButtonWidget(
              color: Colors.redAccent,
              onPressed: () {
                if (selectedImage == null || photoNameController.text.isEmpty) {
                  showCustomSnackbar(
                      context, 'Please input all form', Colors.redAccent);
                }
                typeValidate();
              },
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
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
