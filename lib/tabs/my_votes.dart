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
          _voting(),
        ],
      ),
    );
  }

  Widget _voting() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Challenge:'),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          padding: const EdgeInsets.all(8.0),
          child: Text('To what percent is this school toilet clean? 2019'),
          color: Colors.white,
        )
      ],
    ),
  );
}
