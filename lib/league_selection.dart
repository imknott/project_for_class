import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dashboard.dart';

/* TO DO: ADD IT TO THE ONBOARDING PROCESS */

//leagues that user selects will be in this first list (info from onboarding)
List<Tuple2<String, int>> leagues = [];
//leagues that the user hasn't selected will be put in this list
List<Tuple2<String, int>> unfollowedLeagues = [
  Tuple2<String, int>('MLS', 1),
  Tuple2<String, int>('NBA', 2),
  Tuple2<String, int>('MLB', 3),
  Tuple2<String, int>('NFL', 4),
  Tuple2<String, int>('EPL', 5),
  Tuple2<String, int>('Bundesliga', 5),
  Tuple2<String, int>('Serie A', 5),
  Tuple2<String, int>('La Liga', 5),
  Tuple2<String, int>('EuroLeague', 6),
  Tuple2<String, int>('Ligue 1', 5),
];

class SelectLeague extends StatefulWidget {
  const SelectLeague({Key? key}) : super(key: key);

  @override
  State<SelectLeague> createState() => _SelectLeagueState();
}

class _SelectLeagueState extends State<SelectLeague> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Leagues'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: () {
              //if already login
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(leagues, unfollowedLeagues)));
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
        itemCount: unfollowedLeagues.length,
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
                  Text(unfollowedLeagues[index].item1),
                ],
              ),

            ),
            onTap: () {
              setState(() {
                leagues.add(unfollowedLeagues[index]);
                unfollowedLeagues.remove(unfollowedLeagues[index]);
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
              return leagues.isEmpty ? Container(
                height: 250,
                child: Text('Empty'),
              ) : Container(
                height: 250,
                child: ListView.builder(
                  itemCount: leagues.length,
                  prototypeItem: ListTile(
                    title: Text(leagues.first.item1),
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: Card(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(child: Text(leagues[index].item1)),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            unfollowedLeagues.add(leagues[index]);
                            leagues.remove(leagues[index]);
                          });
                        }
                    );
                  },
                ),
              );
            },
          );
        },
        child: Icon(Icons.menu),
      ),
    );
  }
}
