import 'package:flutter/material.dart';
import 'package:v2/screens/event.dart';

class EventsTab extends StatefulWidget {
  _EventsTab createState() => _EventsTab();
}

class _EventsTab extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleContainer('Current Update'),
            _newsCard(
                'Maji ya kunywa',
                'Something is coming and it is big and small a girl with stones comes to combe.',
                'https://pbs.twimg.com/media/EM6UnjWXkAEE1RD.jpg'),
            _availableCompetions(),
            _updateLists()
          ],
        ),
      ),
    );
  }

  Widget _titleContainer(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      color: Colors.blueGrey[100],
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.blue),
      ),
    );
  }

  Widget _newsCard(String title, String description, String inageURL) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      color: Colors.blueGrey[100],
      margin: const EdgeInsets.fromLTRB(10, 1, 10, 0),
      child: Card(
        elevation: 0,
        color: Colors.blueGrey[100],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Text('1 Comments'),
                      ),
                      InkWell(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Event()));
                          },
                          child: Text('Read More'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Image.network(
              inageURL,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .3,
            )
          ],
        ),
      ),
    );
  }

  Widget _availableCompetions() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleContainer('Available Competitions'),
          // Divider(
          //   color: Colors.grey,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(10, 1, 10, 0),
            color: Colors.blueGrey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('To what percent is this school toilet clean? 2019'),
                    Text('School tiolet competition')
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('Evaluation')),
              ],
            ),
          ),
          // Divider(
          //   color: Colors.grey,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(10, 1, 10, 0),
            color: Colors.blueGrey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('To what percent is this school toilet clean? 2019'),
                    Text('School tiolet competition')
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('Ended')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _updateLists() {
    return Column(
      children: [
        _titleContainer('Other Updates'),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .4,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _newsCard(
                    'Maji ya kunywa',
                    'Something is coming and it is big and small a girl with stones comes to combe.',
                    'https://pbs.twimg.com/media/EM6UnjWXkAEE1RD.jpg');
              }),
        ),
      ],
    );
  }
}
