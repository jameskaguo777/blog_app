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
          _leagues(context)
        ],
      ),
    );
  }

  Widget _leagues(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Challenge Results:'),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(child: DropdownButtonFormField(items: [
                    
                  ],))
                ],
              )
            ),
          ],
        ),
      );
}
