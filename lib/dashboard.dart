import 'package:flutter/material.dart';
import 'soccer_league_table.dart';

//leagues that user selects will be in this first list (info from onboarding)
List<String> leagues = ['EPL', 'League One', 'Random league', 'Random league 2'];
//leagues that the user hasn't selected will be put in this list
List<String> unfollowedLeagues = ['League 3', 'League 4', 'League 5'];

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(
        itemCount: leagues.length,
        prototypeItem: ListTile(
          title: Text(leagues.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(leagues[index]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => SoccerLeagueTable(leagues[index])));
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: unfollowedLeagues.length,
                prototypeItem: ListTile(
                  title: Text(unfollowedLeagues.first),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(child: Text(unfollowedLeagues[index])),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        leagues.add(unfollowedLeagues[index]);
                        unfollowedLeagues.remove(unfollowedLeagues[index]);
                        Navigator.pop(context);
                      });
                    }
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
      ),
    );
  }
}
