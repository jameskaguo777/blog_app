import 'package:flutter/material.dart';
import 'package:swash_comp/drawer/drawer_widget.dart';
import 'package:swash_comp/tabs/events.dart';
import 'package:swash_comp/tabs/league_table.dart';
import 'package:swash_comp/tabs/my_votes.dart';
import 'package:swash_comp/tabs/wash_ambassadors.dart';

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
              fontSize: 10
            ),
            tabs: [
            Tab(child: Text('MY VOTES'),),
            Tab(child: Text('LEAGUE TABLE'),),
            Tab(child: Text('EVENTS'),),
            Tab(child: Text('WASH AMBASSADORS'),),
          ],),
        ),
        body: SafeArea(
                  child: TabBarView(
            children: [
              MyVotes(),
              LeagueTable(),
              EventsTab(),
              WashAmbassadorsTab(),
            ],
          ),
        ),
        drawer: DrawerWidgetT(),
      ),
    );
  }
}
