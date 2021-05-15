import 'package:flutter/material.dart';

class LeagueTable extends StatefulWidget {
  _LeagueTable createState() => _LeagueTable();
}

class _LeagueTable extends State<LeagueTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('Challenge Results'),
        ],
      ),
    );
  }
}
