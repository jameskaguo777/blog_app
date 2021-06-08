import 'package:flutter/material.dart';

class DrawerWidgetT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      semanticLabel: 'Drawer Menu on Left',
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Column(
            children: [
              Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ), 
                Text('Sinyo Developer', style: TextStyle(color: Colors.white),),
              ],)
            ],
          )),
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
            onTap: () => print('pressed'),
            title: Text('Logout'),
            hoverColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
