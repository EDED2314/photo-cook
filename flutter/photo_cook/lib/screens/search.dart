import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_cook/widgets/coolButtion.dart';
import 'package:photo_cook/widgets/coolText.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  /// Default Constructor
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  bool picked = false;

  @override
  Widget build(BuildContext context) {
    if (!picked) {
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
            ExpandedButton(
                onPressed: () async {
                  try {
                    http.MultipartRequest request = http.MultipartRequest(
                        'GET',
                        Uri.parse(
                            "https://stackoverflow.com/questions/66579874/image-upload-in-flutter-using-http-post-method"));

                    http.StreamedResponse r = await request.send();
                    print(r.statusCode);
                    print(await r.stream.transform(utf8.decoder).join());
                  } catch (e) {
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
                text: "Send",
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
