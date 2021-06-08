import 'package:flutter/material.dart';
import 'package:v2/screens/home.dart';
import 'package:v2/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swash Competition',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Noto Sans KR',
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/': (context) => Login(),
      },
    );
  }
}


