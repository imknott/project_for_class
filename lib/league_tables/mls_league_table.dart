import 'package:flutter/material.dart';
import 'package:project_for_class/schedule.dart';

class MLSLeagueTable extends StatefulWidget {

  final String leagueName;

  MLSLeagueTable(this.leagueName);

  @override
  State<MLSLeagueTable> createState() => _MLSLeagueTableState(leagueName);
}

class _MLSLeagueTableState extends State<MLSLeagueTable> {

  final String leagueName;
  int index = 0;
  _MLSLeagueTableState(this.leagueName);

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
              columnSpacing: 20,
              //make api calls using league name
              columns: const [
                DataColumn(label: Text('Pos',)),
                DataColumn(label: Text('Team')),
                DataColumn(label: Text('Pts')),
                DataColumn(label: Text('P')),
                DataColumn(label: Text('W')),
                DataColumn(label: Text('D')),
                DataColumn(label: Text('L')),
                DataColumn(label: Text('GD')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1',textAlign: TextAlign.center,)),
                  DataCell(
                    Container(
                      width: 100,
                      child: Text('St. Louis')
                    )
                  ),
                  DataCell(Text('9')),
                  DataCell(Text('3')),
                  DataCell(Text('3')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('4')),
                ],
                ),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(
                    Container(
                        width: 100,
                        child: Text('Seattle')
                    )
                  ),
                  DataCell(Text('6')),
                  DataCell(Text('3')),
                  DataCell(Text('2')),
                  DataCell(Text('0')),
                  DataCell(Text('1')),
                  DataCell(Text('5')),
                ]
                ),
              ],
            ),
          ]else...[
            DataTable(
              columnSpacing: 20,
              //make api calls using league name
              columns: const [
                DataColumn(label: Text('Pos',)),
                DataColumn(label: Text('Team')),
                DataColumn(label: Text('Pts')),
                DataColumn(label: Text('P')),
                DataColumn(label: Text('W')),
                DataColumn(label: Text('D')),
                DataColumn(label: Text('L')),
                DataColumn(label: Text('GD')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1',textAlign: TextAlign.center,)),
                  DataCell(
                    Container(
                      width: 100,
                      child: Text('Atlanta United')
                    )
                  ),
                  DataCell(Text('7')),
                  DataCell(Text('3')),
                  DataCell(Text('2')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('4')),
                ],
                ),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(
                    Container(
                        width: 100,
                        child: Text('Nashville')
                    )
                  ),
                  DataCell(Text('7')),
                  DataCell(Text('2')),
                  DataCell(Text('2')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('4')),
                ]
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
