import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

class MLBLeagueTable extends StatefulWidget {

  final String leagueName;

  MLBLeagueTable(this.leagueName,);

  @override
  State<MLBLeagueTable> createState() => _MLBLeagueTableState(leagueName);
}

class _MLBLeagueTableState extends State<MLBLeagueTable> {

  final String leagueName;
  int index = 0;

  _MLBLeagueTableState(this.leagueName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(leagueName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.newspaper),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(leagueName)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 195,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: index==0 ? Colors.black: Colors.black26
                  ),
                  onPressed: () {
                    setState( () {
                      index = 0;
                    });
                  },
                  child: const Text('American League'),
                ),
              ),
              SizedBox(
                width: 195,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: index==1 ? Colors.black: Colors.black26
                  ),
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: const Text('National League'),
                ),
              ),
            ],
          ),
          if(index==0)...[
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'AL EAST',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Yankees')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'AL CENTRAL',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Royals')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'AL WEST',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1')),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Athletics')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ]
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('2')),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Scrollable')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]else...[
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'NL EAST',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Marlins')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'NL CENTRAL',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Reds')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(
                          'NL WEST',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        children: <Widget>[
                          DataTable(
                            columnSpacing: 15,
                            //make api calls using league name
                            columns: const [
                              DataColumn(label: Text('Pos',)),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('GB')),
                              DataColumn(label: Text('L10')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1')),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Dodgers')
                                    )
                                  ),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.000')),
                                  DataCell(Text('-')),
                                  DataCell(Text('0-0')),
                                ]
                              ),
                              DataRow(
                                  cells: [
                                    DataCell(Text('2')),
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text('Scrollable')
                                      )
                                    ),
                                    DataCell(Text('0')),
                                    DataCell(Text('0')),
                                    DataCell(Text('.000')),
                                    DataCell(Text('-')),
                                    DataCell(Text('0-0')),
                                  ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
