import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'package:v2/screens/home.dart';
import 'package:v2/screens/login.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final _getTokenController = Get.put(CheckTokenController());
  @override
  void initState() {
    super.initState();
    _checkToken();
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
      ),
    );
  }

  void _checkToken() {
    if (_getTokenController.token.value != '' &&
        _getTokenController.token.value != null &&
        _getTokenController.token.value != 'null' &&
        _getTokenController.token.value != null) {
      print('splashscreen ${_getTokenController.token}');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(seconds: 4), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      });
    } else {
      print('splashscreen ${_getTokenController.token.value}');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        });
      });
    }
  }
}
