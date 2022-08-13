import 'package:flutter/material.dart';
import 'package:photo_cook/nav_bar.dart';


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Cook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navbar(),
    );
  }
}
