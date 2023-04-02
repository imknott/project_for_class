import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api_service/api_service.dart';

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
        title: Text('${teamName} Matches'),
        backgroundColor: Colors.amber,
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
          return Card(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text("${_gameModel![index].homeTeam?.nickname}"),
                SizedBox(height: 20),
                if((_gameModel![index].time)!.compareTo(DateTime.now().toString()) < 0)...[
                  Text(
                    _gameModel![index].home?.points==null ?
                      "score unavailable" : "${_gameModel![index].home?.points}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("-"),
                  Text(
                    _gameModel![index].visitor?.points==null ?
                    "score unavailable" : "${_gameModel![index].visitor?.points}",
                    style: TextStyle(fontSize: 20),
                  ),
                ] else...[
                  Text("${DateFormat.yMMMd().format(DateTime.parse(_gameModel![index].time!).toLocal())}",),
                  Text("${DateFormat.Hm().format(DateTime.parse(_gameModel![index].time!).toLocal())}",),
                ],
                SizedBox(height: 20),
                Text("${_gameModel![index].visitorTeam?.nickname}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
