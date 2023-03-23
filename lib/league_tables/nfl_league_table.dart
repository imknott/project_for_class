import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

class NFLLeagueTable extends StatefulWidget {

  final String leagueName;

  NFLLeagueTable(this.leagueName,);

  @override
  State<NFLLeagueTable> createState() => _NFLLeagueTableState(leagueName);
}

class _NFLLeagueTableState extends State<NFLLeagueTable> {

  final String leagueName;
  int index = 0;

  _NFLLeagueTableState(this.leagueName);

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
                  child: const Text('American Football Conference', textAlign: TextAlign.center,),
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
                  child: const Text('National Football Conference', textAlign: TextAlign.center,),
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
                          'AFC EAST',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Bills')
                                    )
                                  ),
                                  DataCell(Text('13')),
                                  DataCell(Text('3')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.813')),
                                  DataCell(Text('W7')),
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
                          'AFC WEST',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                      Container(
                                          width: 100,
                                          child: Text('Chiefs')
                                      )
                                  ),
                                  DataCell(Text('14')),
                                  DataCell(Text('3')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.824')),
                                  DataCell(Text('W5')),
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
                          'AFC NORTH',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1',textAlign: TextAlign.center,)),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: Text('Bengals')
                                    )
                                  ),
                                  DataCell(Text('12')),
                                  DataCell(Text('4')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.750')),
                                  DataCell(Text('W8')),
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
                          'AFC SOUTH',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                  cells: [
                                    DataCell(Text('1')),
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text('Jaguars')
                                      )
                                    ),
                                    DataCell(Text('9')),
                                    DataCell(Text('8')),
                                    DataCell(Text('0')),
                                    DataCell(Text('.529')),
                                    DataCell(Text('W5')),
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
                          'NFC EAST',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1')),
                                  DataCell(
                                      Container(
                                          width: 100,
                                          child: Text('Eagles')
                                      )
                                  ),
                                  DataCell(Text('14')),
                                  DataCell(Text('3')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.824')),
                                  DataCell(Text('W1')),
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
                          'NFC WEST',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1')),
                                  DataCell(
                                      Container(
                                          width: 100,
                                          child: Text('49ers')
                                      )
                                  ),
                                  DataCell(Text('13')),
                                  DataCell(Text('4')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.765')),
                                  DataCell(Text('W10')),
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
                          'NFC NORTH',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('1')),
                                  DataCell(
                                      Container(
                                          width: 100,
                                          child: Text('Vikings')
                                      )
                                  ),
                                  DataCell(Text('13')),
                                  DataCell(Text('4')),
                                  DataCell(Text('0')),
                                  DataCell(Text('.765')),
                                  DataCell(Text('W1')),
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
                          'NFC SOUTH',
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
                              DataColumn(label: Text('T')),
                              DataColumn(label: Text('Pct')),
                              DataColumn(label: Text('Strk')),
                            ],
                            rows: [
                              DataRow(
                                  cells: [
                                    DataCell(Text('1')),
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text('Buccaneers')
                                      )
                                    ),
                                    DataCell(Text('8')),
                                    DataCell(Text('9')),
                                    DataCell(Text('0')),
                                    DataCell(Text('.471')),
                                    DataCell(Text('L1')),
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
