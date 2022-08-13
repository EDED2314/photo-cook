import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_cook/widgets/coolButtion.dart';
import 'package:photo_cook/widgets/coolText.dart';
import 'package:http/http.dart' as http;

import 'http.dart';

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  XFile? imageFile;
  bool picked = false;
  Data cool = const Data(detections: ["Loading"], results: ["Loading"]);
  @override
  Widget build(BuildContext context) {
    if (!picked) {
      return Scaffold(
        appBar: AppBar(
          title: const coolText(
            text: "What To Cook",
            fontSize: 14,
          ),
        ),
        body: Center(
            child: Column(
          children: [
            const Spacer(),
            ExpandedButton(
                onPressed: () async {
                  try {
                    final pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {
                        imageFile = pickedImage;
                        picked = true;
                      });
                    }
                    http.MultipartRequest request = http.MultipartRequest(
                        'POST',
                        Uri.parse("http://192.168.0.133:5000/api/cook"));

                    request.files.add(
                      await http.MultipartFile.fromPath(
                        'images',
                        imageFile!.path,
                      ),
                    );
                    http.StreamedResponse r = await request.send();
                    final response = await http
                        .get(Uri.parse('http://192.168.0.133:5000/api/cook'));
                    cool = Data.fromJson(jsonDecode(response.body));
                  } catch (e) {
                    imageFile = null;
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: coolText(
                          text: e.toString(),
                          fontSize: 5,
                        ),
                      ));
                    }
                  }
                },
                text: "Take Photo",
                flex: 2,
                fontSize: 15,
                width: 200),
            const Spacer(),
          ],
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const coolText(
            text: "Cooker",
            fontSize: 14,
          ),
        ),
        body: Center(
            child: Column(
          children: [
            const Spacer(),
            const coolText(text: "Data", fontSize: 15),
            const Spacer(),
            ExpandedButton(
                onPressed: () {
                  setState(() {
                    picked = false;
                  });
                },
                text: "Take Photo Again",
                flex: 1,
                fontSize: 12,
                width: 150),
            const Spacer(),
          ],
        )),
      );
    }
  }
}
