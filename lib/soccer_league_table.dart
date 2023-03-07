import 'package:flutter/material.dart';


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
        appBar: AppBar(
          title: Text(leagueName),
        ),
        body: DataTable(
          columnSpacing: 28,
          //make api calls using league name
          columns: const [
            DataColumn(label: Text('Pos')),
            DataColumn(label: Text('Club')),
            DataColumn(label: Text('P')),
            DataColumn(label: Text('W')),
            DataColumn(label: Text('D')),
            DataColumn(label: Text('L')),
            DataColumn(label: Text('GD')),
            DataColumn(label: Text('Pts')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('ARS')),
              DataCell(Text('26')),
              DataCell(Text('20')),
              DataCell(Text('3')),
              DataCell(Text('3')),
              DataCell(Text('34')),
              DataCell(Text('63')),
            ],
            ),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('MCI')),
              DataCell(Text('18')),
              DataCell(Text('4')),
              DataCell(Text('4')),
              DataCell(Text('3')),
              DataCell(Text('41')),
              DataCell(Text('58')),
            ]
            ),
          ],
      ),
    );
  }
}
