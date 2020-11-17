import 'package:flutter/material.dart';

class WashAmbassadorsTab extends StatefulWidget {
  _WashAmbassadorsTab createState() => _WashAmbassadorsTab();
}

class _WashAmbassadorsTab extends State<WashAmbassadorsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('Recognition'),
        ],
      ),
    );
  }
}
