import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'odds_api.dart';

class Match extends StatefulWidget {

  final String? league;
  final String? home;
  final String? away;
  final String id;

  Match(this.league, this.home, this.away, this.id);

  @override
  State<Match> createState() => _MatchState(league, home, away, id);

}

class _MatchState extends State<Match> {

  final String? league;
  final String? home;
  final String? away;
  final String id;
  bool ready = false;
  late Future<List<Odds>?> _odds;

  @override
  void initState() {
    super.initState();
    _getData();
    ready = true;
  }

  void _getData() async {
    _odds = fetchOdds();

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  _MatchState(this.league, this.home, this.away, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$league -   $home : $away',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: FutureBuilder(
        future: _odds,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            return ListView(
              children: [
                const SizedBox(height: 20,),
                Card(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      //game date
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Text(snapshot.data[0].date, textAlign: TextAlign.right,),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      //team names and score/game time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                home!,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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


