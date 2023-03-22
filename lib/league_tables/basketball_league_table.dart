import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

class BasketballLeagueTable extends StatefulWidget {

  final String leagueName;

  BasketballLeagueTable(this.leagueName);

  @override
  State<BasketballLeagueTable> createState() => _BasketballLeagueTableState(leagueName);
}

class _BasketballLeagueTableState extends State<BasketballLeagueTable> {

  final String leagueName;

  _BasketballLeagueTableState(this.leagueName);

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
        columnSpacing: 28,
        //make api calls using league name
        columns: const [
          DataColumn(label: Text('Pos',)),
          DataColumn(label: Text('Team')),
          DataColumn(label: Text('P')),
          DataColumn(label: Text('W')),
          DataColumn(label: Text('L')),
          DataColumn(label: Text('Diff')),
          DataColumn(label: Text('Pts')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1',textAlign: TextAlign.center,)),
              DataCell(Text('Olympiacos')),
              DataCell(Text('28')),
              DataCell(Text('20')),
              DataCell(Text('8')),
              DataCell(Text('258')),
              DataCell(Text('40')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('Real Madrid')),
              DataCell(Text('27')),
              DataCell(Text('19')),
              DataCell(Text('8')),
              DataCell(Text('178')),
              DataCell(Text('38')),
            ]
          ),
        ],
      ),
    );
  }
}
