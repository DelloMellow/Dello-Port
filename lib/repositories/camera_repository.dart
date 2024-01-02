import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CameraRepository {
  final BuildContext context;
  final picker = ImagePicker();
  final Function(List<XFile>) onImagesChanged;

  CameraRepository(this.context, {required this.onImagesChanged});

  Future<void> showOption(List<XFile> images) async {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                // get image from gallery
                await getImageFromGallery(images);
              },
            ),

            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                // get image from camera
                await getImageFromCamera(images);
              },
            ),
          ],
        ),
      );
    } catch (e) {
      throw Exception("Error showing options: $e");
    }
  }

  Future<void> getImageFromGallery(List<XFile> images) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        images.add(XFile(pickedFile.path));
        onImagesChanged(images); // Call the callback function here
      }
    } catch (e) {
      throw Exception("Error picking image from gallery: $e");
    }
  }

  Future<void> getImageFromCamera(List<XFile> images) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        images.add(XFile(pickedFile.path));
        onImagesChanged(images); // Call the callback function here
      }
    } catch (e) {
      throw Exception("Error capturing image from camera: $e");
    }
  }
}