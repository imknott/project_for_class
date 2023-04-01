import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/new_dash.dart';

import 'api_service.dart';

class Match extends StatefulWidget {

  final String id;

  const Match(this.id);

  @override
  State<Match> createState() => _MatchState(this.id);

}



class _MatchState extends State<Match> {
  late List<Scores> futureGame = [];
  final String? id;
  _MatchState(this.id);
  String league = "NBA";
  late FirebaseFirestore db;
  late FirebaseAuth _auth;
  int index = -1;
  int secondIndex = -1;


  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _getData();
  }

  void _getData() async {
    futureGame = (await nbaApi().getGameInfo(id!));

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.back_hand),
            onPressed: () {
              //if already login
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyDashPage()));
              //else direct to login/register page.
            },
          ),
        ],
        title: Text(
          'NBA',
        ),
      ),
      body: futureGame == null || futureGame!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ): Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: 300,
                  height: 150,
                  child: Card(
                    //padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.5, color: Colors.grey),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Date:', textAlign: TextAlign.left,),
                                  SizedBox(width: 10,),
                                  Text('${futureGame[0].date?.start.toString().split('T').first}', textAlign: TextAlign.right,),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text('${futureGame[0].homeTeam?.nickname} - ${futureGame[0].home?.points.toString()} : ${futureGame[0].visitor?.points.toString()} - ${futureGame[0].visitorTeam?.nickname}', textAlign: TextAlign.center,),
                              SizedBox(height: 30,),
                            ],
                          )
                        ),
                        Row(
                          children: [
                            Container(
                              width: 192,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if(index==0){
                                      index=-1;
                                    } else{
                                      index = 0;
                                    }
                                  });
                                },
                              child: Text('LINEUPS'),
                              ),
                            ),
                            Container(
                              width: 192,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if(index==1){
                                      index=-1;
                                    } else{
                                      index = 1;
                                    }
                                  });
                                },
                                child: Text('STATS'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  )
                ),
                if(index==0)...[
                  Container(
                    height: 380,
                    width: 380,
                    child: Card(
                      child: Image(image: AssetImage('images/sampleFormation.png')),
                    ),
                  )
                ]else if(index==1)... [
                  Container(
                    height: 380,
                    width: 380,
                    child: Card(
                      child: Image(image: AssetImage('images/sampleStats.png')),
                    ),
                  )
                ],
                if(league=='NFL' || league=='NBA' || league=='MLB' || league == 'MLS')...[
                  Container(
                    height: 50,
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            width: 192,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if(secondIndex==0){
                                    secondIndex=-1;
                                  } else{
                                    secondIndex = 0;
                                  }
                                });
                              },
                              child: Text('WEATHER'),
                            ),
                          ),
                          Container(
                            width: 192,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if(secondIndex==1){
                                    secondIndex=-1;
                                  } else{
                                    secondIndex = 1;
                                  }
                                });
                              },
                              child: Text('LOCATION'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(secondIndex==0)...[
                    Container(
                      height: 150,
                      child: Card(
                        child: Text('Weather', textAlign: TextAlign.center,),
                      ),
                    )
                  ]else if(secondIndex==1)... [
                    Container(
                      height: 150,
                      child: Card(
                        child: Column(
                          children: [
                            Image(image: AssetImage('images/sampleArena.jpg')),
                            Text('Ball Arena')
                          ],
                        ),
                      ),
                    )
                  ],
                ]
              ],
            ),
          ),
        ],
      )
    );
  }
}
