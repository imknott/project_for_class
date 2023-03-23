import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

import '../team_schedule.dart';

class SoccerLeagueTable extends StatefulWidget {

  final String leagueName;

  SoccerLeagueTable(this.leagueName);

  @override
  State<SoccerLeagueTable> createState() => _SoccerLeagueTableState(leagueName);
}

class _SoccerLeagueTableState extends State<SoccerLeagueTable> {

  final String leagueName;

  _SoccerLeagueTableState(this.leagueName);

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
      body: DataTable(
        showCheckboxColumn: false,
        columnSpacing: 28,
        //make api calls using league name
        columns: const [
          DataColumn(label: Text('Pos',)),
          DataColumn(label: Text('Team', textAlign: TextAlign.center,)),
          DataColumn(label: Text('P')),
          DataColumn(label: Text('W')),
          DataColumn(label: Text('D')),
          DataColumn(label: Text('L')),
          DataColumn(label: Text('GD')),
          DataColumn(label: Text('Pts')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1',textAlign: TextAlign.center,)),
              DataCell(Text('Team1')),
              DataCell(Text('26')),
              DataCell(Text('20')),
              DataCell(Text('3')),
              DataCell(Text('3')),
              DataCell(Text('34')),
              DataCell(Text('63')),
            ],
            onSelectChanged: (newValue) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Team1', leagueName)));
            },
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(
                 Text('Team2'),
              ),
              DataCell(Text('18')),
              DataCell(Text('4')),
              DataCell(Text('4')),
              DataCell(Text('3')),
              DataCell(Text('41')),
              DataCell(Text('58')),
            ],
            onSelectChanged: (newValue) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule('Team2', leagueName)));
            },
          ),
        ],
      ),
    );
  }
}
