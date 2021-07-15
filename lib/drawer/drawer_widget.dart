import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v2/controllers/user_controller.dart';
import 'package:v2/screens/login.dart';

class DrawerWidgetT extends StatelessWidget {
  GetStorage box = GetStorage();
  // UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      semanticLabel: 'Drawer Menu on Left',
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      Obx(() {
                        return Text(
                          'Not Set',
                          style: TextStyle(color: Colors.white),
                        );
                      }),
                    ],
                  )
                ],
              )),
          ListTile(
            onTap: () => print('pressed'),
            title: Text('Health Emergency'),
            hoverColor: Colors.cyan,
          ),
          ListTile(
            onTap: () => print('pressed'),
            title: Text('Privacy Policy'),
            hoverColor: Colors.cyan,
          ),
          ListTile(
            onTap: () => print('pressed'),
            title: Text('Terms and Condition'),
            hoverColor: Colors.cyan,
          ),
          ListTile(
            onTap: () => print('pressed'),
            title: Text('Rate App'),
            hoverColor: Colors.cyan,
          ),
          ListTile(
            onTap: () => print('pressed'),
            title: Text('Share App'),
            hoverColor: Colors.cyan,
          ),
          ListTile(
            onTap: () {
              box.write('access_token', 'null');
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              });
            },
            title: Text('Logout'),
            hoverColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
