import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_cook/widgets/coolButtion.dart';
import 'package:photo_cook/widgets/coolText.dart';
import 'package:http/http.dart' as http;

class Data {
  final List detections;
  final List results;

  const Data({
    required this.detections,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      detections: json['detections'],
      results: json['results'],
    );
  }
}

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  Future<void> sendData() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = pickedImage;
          picked = true;
        });
      }
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse("http://192.168.0.133:5000/api/cook"));

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          imageFile!.path,
        ),
      );
      http.StreamedResponse r = await request.send();
      final response =
          await http.get(Uri.parse('http://192.168.0.133:5000/api/cook'));
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
      setState(() {
        picked = false;
      });
    }
  }

  XFile? imageFile;
  bool picked = false;
  Data cool = const Data(detections: ["Loading"], results: ["Loading"]);
  @override
  Widget build(BuildContext context) {
    if (cool.detections[0] == "Loading") {
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
              const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: coolText(
                        text:
                            "It is Recommended to take the Photo in Birds-eye-view",
                        fontSize: 18),
                  )),
              const Spacer(
                flex: 3,
              ),
              ExpandedButton(
                  onPressed: () async {
                    await sendData();
                    setState(() {});
                    print(cool.detections);
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const coolText(
            text: "Cooker",
            fontSize: 14,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 680,
            child: Center(
                child: Column(
              children: [
                const Spacer(),
                const coolText(text: "What we detected", fontSize: 18),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: cool.detections.length,
                    itemBuilder: (context, index) {
                      final item = cool.detections[index];
                      return Expanded(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: coolText(text: item, fontSize: 12)));
                    },
                  ),
                ),
                const Spacer(),
                const coolText(text: "Results", fontSize: 18),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: cool.results.length,
                    itemBuilder: (context, index) {
                      final item = cool.results[index]["title"];
                      final image = cool.results[index]["image"];
                      final url = cool.results[index]["url"];
                      if (cool.results[0]["title"] != null) {
                        return Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60),
                                    child: TextButton(
                                      child: coolText(text: item, fontSize: 12),
                                      onPressed: () async {
                                        ClipboardData data =
                                            ClipboardData(text: url);
                                        await Clipboard.setData(data);
                                        if (mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: coolText(
                                              text: "Copied Link",
                                              fontSize: 12,
                                            ),
                                          ));
                                        }
                                      },
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  child: Image.network(image),
                                ),
                              ],
                            ));
                      } else {
                        return const Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child:
                                    coolText(text: "No Data", fontSize: 12)));
                      }
                    },
                  ),
                ),
                const Spacer(),
                ExpandedButton(
                    onPressed: () {
                      setState(() {
                        picked = false;
                        cool.detections[0] = "Loading";
                        cool.results[0] = "Loading";
                      });
                    },
                    text: "Take Photo Again",
                    flex: 1,
                    fontSize: 12,
                    width: 150),
                const Spacer(),
              ],
            )),
          ),
        ),
      );
    }
  }
}
