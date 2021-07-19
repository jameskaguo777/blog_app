import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/old_api_controller/wash_ambassador_controller.dart';

class WashAmbassadorsTab extends StatefulWidget {
  _WashAmbassadorsTab createState() => _WashAmbassadorsTab();
}

class _WashAmbassadorsTab extends State<WashAmbassadorsTab> {
  final _washAmbassador = Get.put(WashAmbassador());

  @override
  void initState() {
    super.initState();
    _washAmbassador.getAmbassador();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _leagues(context),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: FloatingActionButton.extended(onPressed: () {}, label: Text('Refresh')))
          ],
        ),
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
            Text('Recognition: Best WASH Ambossadors'),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                          child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Type to search',
                            prefixIcon: Icon(Icons.search)),
                      )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Obx(() {
                        if (_washAmbassador.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'No.',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ambassador Name',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Votes',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              ..._washAmbassador.ambassador.map(
                                (element) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(element['user_id'])),
                                    DataCell(Text(element['name'])),
                                    DataCell(Text(element['votes_count'])),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    )
                  ],
                )),
          ],
        ),
      );
}
