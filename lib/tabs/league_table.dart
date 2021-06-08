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
        children: [_leagues(context)],
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        child: DropdownButtonFormField<String>(
                          // value: _ratingController,
                          items: [
                            'Current Challenge Results',
                            'Mtakuja Challenge',
                            'Majuma anasemaje',
                            'Mlimwa Shule',
                            'Kwanini Primary School'
                          ]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Choose a challenge'),
                          onChanged: (value) {
                            setState(() {
                              // _ratingController = value;
                            });
                          },
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
                              'Score %',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: const <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('1'),),
                              DataCell(Text('Mwajuma School')),
                              DataCell(Text('69')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('2')),
                              DataCell(Text('Maendeleo ni Lazima School')),
                              DataCell(Text('63')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('3')),
                              DataCell(Text('Mnasemaje School')),
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
