import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2/controllers/old_api_controller/league_table_controller.dart';

class LeagueTable extends StatefulWidget {
  _LeagueTable createState() => _LeagueTable();
}

class _LeagueTable extends State<LeagueTable> {
  final _leagueTableController = Get.put(LeagueTableController());
  String selectedItem;
  @override
  void initState() {
    super.initState();
    _leagueTableController.getCompetition();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Obx(() {
              if (_leagueTableController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return _leagues(context);
              }
            })
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
            Text('Challenge Results:'),
            Container(
                width: double.infinity,
                // margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                // padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        child: DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (String string) =>
                              setState(() => selectedItem = string),
                          selectedItemBuilder: (BuildContext context) {
                            return _leagueTableController.competitions
                                .map<Widget>((dynamic item) {
                              print('selected item ${selectedItem}');
                              return Text(item['name']);
                            }).toList();
                          },
                          items: _leagueTableController.competitions
                              .map((dynamic item) {
                            return DropdownMenuItem<String>(
                              child: Text(item['name']),
                              value: item['id'],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            numeric: true,
                            label: Text(
                              'No.',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'School Name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Built Year',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Score %',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: const <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text('1'),
                              ),
                              DataCell(Text('Mwajuma School')),
                              DataCell(Text('1934')),
                              DataCell(Text('69')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('2')),
                              DataCell(Text('Maendeleo ni Lazima School')),
                              DataCell(Text('1994')),
                              DataCell(Text('63')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('3')),
                              DataCell(Text('Mnasemaje School')),
                              DataCell(Text('1984')),
                              DataCell(Text('53')),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      );
}
