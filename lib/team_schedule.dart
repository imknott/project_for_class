import 'package:flutter/material.dart';
import 'match_page.dart';
import 'dashboard.dart';

List<String> awayTeams = [
  'Away team 1', 'Away team 2', 'Away team 3', 'Away team 4', 'Away team 5', 'Away team 6', 'Away team 7'
];

class TeamSchedule extends StatefulWidget {

  final String leagueName;
  final String teamName;
  TeamSchedule(this.teamName, this.leagueName);

  @override
  State<TeamSchedule> createState() => _TeamScheduleState(teamName, leagueName);
}

class _TeamScheduleState extends State<TeamSchedule> {
  final String teamName;
  final String leagueName;
  _TeamScheduleState(this.teamName, this.leagueName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${teamName} Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              //     builder: (context) => Dashboard()), (route) => false);
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: awayTeams.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              //child: Image(image: AssetImage('images/trophy.png')),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(teamName),
                  SizedBox(height: 50),
                  Text(
                    'Date of game or result of game',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Text(awayTeams[index]),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Match(leagueName, teamName, awayTeams[index])));
            },
          );
        },
      ),
    );
  }
}
