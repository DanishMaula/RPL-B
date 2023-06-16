import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/provider/event_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/utils/helper.dart';

import '../common_widget/text_field_widget.dart';
import '../provider/memories_provider.dart';
import '../utils/image_picker_util.dart';

class UploadPhotoPage extends StatefulWidget {
  final String type;

  final String? people;
  final String? event;
  static const routeName = '/upload_photo_page';

  const UploadPhotoPage({
    Key? key,
    required this.type,
    this.people,
    this.event,
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
    if (widget.type == 'people') {
      print('people');
      Provider.of<PeopleProvider>(context, listen: false)
          .uploadPeopleImage(selectedImage!, 'miqdad', photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    } else if (widget.type == 'event_image' && widget.event != null) {
      print('event_image');
      Provider.of<EventProvider>(context, listen: false)
          .uploadEventImage(
              selectedImage!, widget.event!, photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    } else if (widget.type == 'event') {
      print('event');
      Provider.of<EventProvider>(context, listen: false)
          .uploadEvent(selectedImage!, photoNameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    } else {
      print('memories');
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
