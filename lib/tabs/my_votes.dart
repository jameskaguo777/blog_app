import 'package:flutter/material.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('Challenge'),
        ],
      ),
    );
  }
}
