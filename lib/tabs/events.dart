import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/old_api_controller/events_controller.dart';
import 'package:v2/screens/challenge_details.dart';
import 'package:v2/screens/event.dart';

class EventsTab extends StatefulWidget {
  _EventsTab createState() => _EventsTab();
}

class _EventsTab extends State<EventsTab> {
  final _eventController = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    _eventController.getPost();
    _eventController.getCompetition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(child: Obx(() {
        if (_eventController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (_eventController.posts.isNotEmpty) {
            return Column(children: [
              _titleContainer('Current Update'),
              _newsCard(_eventController.posts[0]['title'], '_',
                  'https://pbs.twimg.com/media/EM6UnjWXkAEE1RD.jpg'),
              ..._eventController.competitions
                  .map((element) => _availableCompetions(element['name'])),
              _updateLists()
            ]);
          } else {
            return Center(
              child: Text('No availble post yet'),
            );
          }
        }
      })),
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
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * .26,
            )
          ],
        ),
      ),
    );
  }

  Widget _availableCompetions(String title) {
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
                Flexible(
                  flex: 2,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('School tiolet competition')
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChallengeDetails()));
                    },
                    child: Text('Evaluation'),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) => 0),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                  ),
                ),
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
                Flexible(
                  flex: 2,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text('To what percent is this school toilet clean? 2019'),
                      Text('School tiolet competition')
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Ended'),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) => 0),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                  ),
                ),
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
        ..._eventController.posts.map((element) => _newsCard(element['title'],
            'description', 'https://pbs.twimg.com/media/EM6UnjWXkAEE1RD.jpg')),
      ],
    );
  }
}
