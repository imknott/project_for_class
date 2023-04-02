import 'package:flutter/material.dart';
import 'api_service.dart';
import 'match_page.dart';
import 'dashboard.dart';

List<String> awayTeams = [
  'Away team 1', 'Away team 2', 'Away team 3', 'Away team 4', 'Away team 5', 'Away team 6', 'Away team 7'
];

class TeamSchedule extends StatefulWidget {
  final String id;
  final String teamName;

  TeamSchedule(this.teamName,this.id);

  @override
  State<TeamSchedule> createState() => _TeamScheduleState(teamName,id);
}

class _TeamScheduleState extends State<TeamSchedule> {
  final String teamName;
  final String id;
  _TeamScheduleState(this.teamName,this.id);
  late List<Scores>? _gameModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _gameModel = (await nbaApi().getTeamsGames(id));

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
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
      body: _gameModel == null || _gameModel!.isEmpty
    ? const Center(
        child: CircularProgressIndicator(),
      ) : GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _gameModel?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              //child: Image(image: AssetImage('images/trophy.png')),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("${_gameModel![index].homeTeam?.nickname}"),
                  SizedBox(height: 50),
                  Text(
                    'Date of game or result of game',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Text("${_gameModel![index].visitorTeam?.nickname}"),
                ],
              ),
            ),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Match( teamName, awayTeams[index])));
            },
          );
        },
      ),
    );
  }
}
