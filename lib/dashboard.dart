import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/user_page.dart';
import 'league_tables/basketball_league_table.dart';
import 'league_tables/mlb_league_table.dart';
import 'league_tables/mls_league_table.dart';
import 'league_tables/nba_league_table.dart';
import 'league_tables/nfl_league_table.dart';
import 'league_tables/soccer_league_table.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> leagues = ['NBA', "NFL", "MLB", "MLS"];
  List<String> unfollowedLeagues = [];
  List<String> leagueLogo = ['images/Logo-NBA.png','images/nflLogo.png','images/mlbLogo.png','images/mlsCrestLogo.png'];
  _DashboardState();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text('Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                //if already login
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserPage()));
                //else direct to login/register page.
              },
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    Image.asset(leagueLogo[index], height: 70,),
                    Text(leagues[index]),
                  ],
                ),
              ),
              onTap: () {
                if (leagues[index].contains("MLS")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MLSLeagueTable(leagues[index])));
                } else if (leagues[index].contains("NBA")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NBALeagueTable(leagues[index])));
                } else if (leagues[index].contains("MLB")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MLBLeagueTable(leagues[index])));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NFLLeagueTable(leagues[index])));
                }
                ;
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
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.amber, foregroundColor: Colors.blueGrey,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 250,
                  child: ListView.builder(
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
                              child:
                              Center(child: Text(unfollowedLeagues[index])),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              leagues.add(unfollowedLeagues[index]);
                              unfollowedLeagues.remove(
                                  unfollowedLeagues[index]);
                              Navigator.pop(context);
                            });
                          });
                    },
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dashboard'),
          backgroundColor: Colors.amber,
          actions: <Widget>[
            TextButton(
              child: const Text('Sign in',style: TextStyle(color: Colors.blueGrey),),
              onPressed: () {
                //if already login
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  LoginScreen()));
                //else direct to login/register page.
              },
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: leagues.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                color: Colors.white,
                //child: Image(image: AssetImage('images/trophy.png')),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(leagueLogo[index],height: 70,),
                    Text(leagues[index]),
                  ],
                ),
              ),
              onTap: () {
                if (leagues[index].contains("MLS")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MLSLeagueTable(leagues[index])));
                } else if (leagues[index].contains("NBA")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NBALeagueTable(leagues[index])));
                } else if (leagues[index].contains("MLB")) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MLBLeagueTable(leagues[index])));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NFLLeagueTable(leagues[index])));
                }
                ;
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
          backgroundColor: Colors.amber,
          foregroundColor: Colors.blueGrey,
          onPressed: () {
            if (unfollowedLeagues.isNotEmpty) {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 250,
                    child: ListView.builder(
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
                                child:
                                Center(child: Text(unfollowedLeagues[index])),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                leagues.add(unfollowedLeagues[index]);
                                unfollowedLeagues.remove(
                                    unfollowedLeagues[index]);
                                Navigator.pop(context);
                              });
                            });
                      },
                    ),
                  );
                },
              );
            } else {

            }
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
