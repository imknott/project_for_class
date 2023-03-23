import 'package:flutter/material.dart';
import 'package:project_for_class/user_page.dart';
import 'league_tables/basketball_league_table.dart';
import 'league_tables/mlb_league_table.dart';
import 'league_tables/mls_league_table.dart';
import 'league_tables/nba_league_table.dart';
import 'league_tables/nfl_league_table.dart';
import 'league_tables/soccer_league_table.dart';

class Dashboard extends StatefulWidget {

  final leagues;
  final unfollowedLeagues;

  Dashboard(this.leagues, this.unfollowedLeagues);

  @override
  State<Dashboard> createState() => _DashboardState(leagues, unfollowedLeagues);
}

class _DashboardState extends State<Dashboard> {

  final leagues;
  final unfollowedLeagues;

  _DashboardState(this.leagues, this.unfollowedLeagues);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              //if already login
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
              //else direct to login/register page.
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              color: Colors.white,
              //child: Image(image: AssetImage('images/trophy.png')),
              child: Column(
                children: [
                  Container(
                    height: 100.0,
                    child: SizedBox(height:30,child:Text('image')),
                  ),
                  Text(leagues[index].item1),
                ],
              ),

            ),
            onTap: () {
              if(leagues[index].item2==1){
                Navigator.push(context, MaterialPageRoute(builder:(context) => MLSLeagueTable(leagues[index].item1)));
              }
              else if(leagues[index].item2==2){
                Navigator.push(context, MaterialPageRoute(builder:(context) => NBALeagueTable(leagues[index].item1)));
              }
              else if(leagues[index].item2==3){
                Navigator.push(context, MaterialPageRoute(builder:(context) => MLBLeagueTable(leagues[index].item1)));
              }
              else if(leagues[index].item2==4){
                Navigator.push(context, MaterialPageRoute(builder:(context) => NFLLeagueTable(leagues[index].item1)));
              }
              else if(leagues[index].item2==5){
                Navigator.push(context, MaterialPageRoute(builder:(context) => SoccerLeagueTable(leagues[index].item1)));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder:(context) => BasketballLeagueTable(leagues[index].item1)));
              }
            },
            onDoubleTap: () {
              setState(() {
                unfollowedLeagues.add(leagues[index]);
                leagues.remove(leagues[index]);
              });
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
              return Container(
                height: 250,
                child: ListView.builder(
                  itemCount: unfollowedLeagues.length,
                  prototypeItem: ListTile(
                    title: Text(unfollowedLeagues.first.item1),
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: Card(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(child: Text(unfollowedLeagues[index].item1)),
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
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
