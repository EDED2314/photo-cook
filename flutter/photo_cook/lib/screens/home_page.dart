import 'package:flutter/material.dart';

import '../widgets/coolText.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 22,
            ),
            const SizedBox(
              width: 300,
              child: coolText(
                text: 'Welcome to Photo Cook!',
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(12), // Border radius
                child: ClipOval(
                  child: Image.asset(
                    "lib/assets/images.png",
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 40,
            ),
            const coolText(
                text: "click one of the buttons below to get started",
                fontSize: 8),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
