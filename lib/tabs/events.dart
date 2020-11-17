import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  _EventsTab createState() => _EventsTab();
}

class _EventsTab extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('Current Updates'),
        ],
      ),
    );
  }
}
