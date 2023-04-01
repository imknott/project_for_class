import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Match extends StatefulWidget {

  final String league;
  final String home;
  final String away;

  const Match(this.id);

  @override
  State<Match> createState() => _MatchState(league, home, away);

}



class _MatchState extends State<Match> {

  final String league;
  final String home;
  final String away;
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
                          ),
                          Expanded(
                            flex: 0,
                            child: Text(
                              snapshot.data[0].time,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Text(
                                away!,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: Text(
                          '00 - 00',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      //game date
                      const Text('Who will win?', textAlign: TextAlign.right,),
                      const SizedBox(height: 30,),
                      //team names and score/game time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 100,
                            child: GestureDetector(
                              onTap: (){},
                              child: Card(
                                child: Column(
                                  children: [
                                    Text(
                                      home!,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      snapshot.data[0].homeOdds,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          SizedBox(
                            width: 160,
                            height: 100,
                            child: GestureDetector(
                              onTap: (){},
                              child: Card(
                                child: Column(
                                  children: [
                                    Text(
                                      away!,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      snapshot.data[0].awayOdds,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) { //checks if the response throws an error
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

Future<List<Odds>?> fetchOdds() async {
  var headers = {
    'x-rapidapi-key': '1bb8997ee5e91a27b5b22bacc064405a',
    'x-rapidapi-host': 'v1.basketball.api-sports.io'
  };
  try {
    Response response = await get(
      //to change
      Uri.parse('https://v1.basketball.api-sports.io/odds?season=2022-2023&bet=2&league=12'),
      headers: headers
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body)['response'];
      final oddsList = decodedResponse.map<Odds>((e) => Odds.fromJson(e)).toList();
      return oddsList;
    }
  } catch (e) {
    throw Exception("Failed to connect to API: $e");
  }
  return null;
}


