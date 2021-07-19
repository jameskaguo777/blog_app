import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v2/controllers/user_controller.dart';
import 'package:v2/drawer/drawer_widget.dart';
import 'package:v2/tabs/events.dart';
import 'package:v2/tabs/league_table.dart';
import 'package:v2/tabs/my_votes.dart';
import 'package:v2/tabs/wash_ambassadors.dart';

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // final _userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    // _userController.userDetails();

    // GetStorage().listenKey(
    //     'access_token', (value) => print('from listen token $value'));
  }

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
                fontWeight: FontWeight.w500, decoration: TextDecoration.none, fontSize: 12),
            tabs: [
              Tab(
                child: Text('MY VOTES'),
              ),
              Tab(
                child: Text('LEAGUE TABLE'),
              ),
              Tab(
                child: Text('EVENTS'),
              ),
              Tab(
                child: Text('WASH AMBASSADORS'),
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
                MyVotes(),
                LeagueTable(),
                EventsTab(),
                WashAmbassadorsTab(),
              ],
            ),
          ),
        ),
        drawer: DrawerWidgetT(),
      ),
    );
  }
}
