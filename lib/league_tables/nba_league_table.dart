import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

import '../team_schedule.dart';

class NBALeagueTable extends StatefulWidget {

  final String leagueName;

  NBALeagueTable(this.leagueName);


  @override
  State<NBALeagueTable> createState() => _NBALeagueTableState(leagueName);
}



class _NBALeagueTableState extends State<NBALeagueTable> {

  final String leagueName;
  int index = 0;

  _NBALeagueTableState(this.leagueName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.amber,
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
                  child: Text('West'),
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
                  child: Text('East'),
                ),
              ),
            ],
          ),
          if(index==0)...[
            DataTable(
              showCheckboxColumn: false,
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
                DataColumn(label: Text('Strk')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('1',textAlign: TextAlign.center,)),
                    DataCell(
                      Container(
                          width: 100,
                          child: Text('Nuggets')
                      )
                    ),
                    DataCell(Text('46')),
                    DataCell(Text('21')),
                    DataCell(Text('.687')),
                    DataCell(Text('-')),
                    DataCell(Text('7-3')),
                    DataCell(Text('L2')),
                  ],
                  onSelectChanged: (newValue) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Nuggets')));
                  },
                ),
                DataRow(
                  cells: [
                    DataCell(Text('2')),
                    DataCell(
                      Container(
                        width: 100,
                        child: Text('Kings')
                      )
                    ),
                    DataCell(Text('40')),
                    DataCell(Text('26')),
                    DataCell(Text('.606')),
                    DataCell(Text('5.5')),
                    DataCell(Text('8-2')),
                    DataCell(Text('W3')),
                  ],
                  onSelectChanged: (newValue) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Kings')));
                  },
                ),
              ],
            ),
          ]else...[
            DataTable(
              showCheckboxColumn: false,
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
                DataColumn(label: Text('Strk')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('1',textAlign: TextAlign.center,)),
                    DataCell(
                      Container(
                        width: 100,
                        child: Text('Bucks')
                      )
                    ),
                    DataCell(Text('48')),
                    DataCell(Text('19')),
                    DataCell(Text('.716')),
                    DataCell(Text('-')),
                    DataCell(Text('8-2')),
                    DataCell(Text('L1')),
                  ],
                  onSelectChanged: (newValue) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Bucks')));
                  },
                ),
                DataRow(
                  cells: [
                    DataCell(Text('2')),
                    DataCell(
                      Container(
                        width: 100,
                        child: Text('Celtics')
                      )
                    ),
                    DataCell(Text('47')),
                    DataCell(Text('21')),
                    DataCell(Text('.691')),
                    DataCell(Text('1.5')),
                    DataCell(Text('6-4')),
                    DataCell(Text('W2')),
                  ],
                  onSelectChanged: (newValue) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Celtics')));
                  },
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
