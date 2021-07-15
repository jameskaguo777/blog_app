import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v2/controllers/authontication_controller.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'package:v2/screens/home.dart';
import 'package:v2/screens/login.dart';
import 'package:v2/screens/temp.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  // final _getTokenController = Get.put(CheckTokenController());
  // final _authonticationController = Get.put(AuthonticationController());
  GetStorage box = GetStorage();
  String userID;
  @override
  void initState() {
    super.initState();
    // _checkToken();
    userID = box.read('user_id');

    userID != null
        ? WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          })
        : Future.delayed(Duration(seconds: 6), () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: Container(
          child: Center(
              child: AnimatedTextKit(animatedTexts: [
            TyperAnimatedText('Welcome',
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
                speed: Duration(milliseconds: 200)),
            ScaleAnimatedText('Swash Competition',
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
                duration: Duration(milliseconds: 4000))
          ])),
        ));
    
  }
}
