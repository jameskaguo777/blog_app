import 'package:flutter/material.dart';
import 'package:v2/drawer/drawer_widget.dart';
import 'package:v2/tabs/events.dart';
import 'package:v2/tabs/league_table.dart';

class SchoolHome extends StatefulWidget {
  SchoolHome({Key key}) : super(key: key);
  _SchoolName createState() => _SchoolName();
}

class _SchoolName extends State<SchoolHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Swash Competition'),
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, decoration: TextDecoration.none),
            tabs: [
              Tab(
                child: Text('EVENTS'),
              ),
              Tab(
                child: Text('LEAGUE TABLE'),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                EventsTab(),
                LeagueTable(),
              ],
            ),
          ),
        ),
        drawer: DrawerWidgetT(),
      ),
    );

  }
}
