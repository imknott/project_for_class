import 'package:flutter/material.dart';

class Match extends StatefulWidget {

  final String league;
  final String home;
  final String away;

  Match(this.league, this.home, this.away);

  @override
  State<Match> createState() => _MatchState(league, home, away);

}

class _MatchState extends State<Match> {

  final String league;
  final String home;
  final String away;
  int index = -1;
  int secondIndex = -1;

  _MatchState(this.league, this.home, this.away);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$home : $away',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Column(
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
                                  Text('$league', textAlign: TextAlign.left,),
                                  SizedBox(width: 10,),
                                  Text('Game Date', textAlign: TextAlign.right,),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text('$home -score or date- $away', textAlign: TextAlign.center,),
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
