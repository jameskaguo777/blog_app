import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  _Event createState() => _Event();
}

class _Event extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Name'),

      ),
      body: SafeArea(child: Text('Soon')),
    );
  }
}
