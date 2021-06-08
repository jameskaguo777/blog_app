import 'package:flutter/material.dart';

class WashAmbassadorsTab extends StatefulWidget {
  _WashAmbassadorsTab createState() => _WashAmbassadorsTab();
}

class _WashAmbassadorsTab extends State<WashAmbassadorsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: DataTable(
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
                        rows: const <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('1')),
                              DataCell(Text('Jane Saxa')),
                              DataCell(Text('69')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('2')),
                              DataCell(Text('Odo Mido')),
                              DataCell(Text('63')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('3')),
                              DataCell(Text('Okolo Michael')),
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
