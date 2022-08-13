import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_cook/widgets/coolButtion.dart';

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Spacer(),
          ExpandedButton(
              onPressed: () async {
                try {
                  final pickedImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    imageFile = pickedImage;
                    setState(() {});
                  }
                } catch (e) {
                  imageFile = null;
                  setState(() {});
                }
              },
              text: "text",
              flex: 2,
              fontSize: 12,
              width: 200),
          const Spacer(),
        ],
      )),
    );
  }
}
