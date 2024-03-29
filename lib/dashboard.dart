import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/team_schedule.dart';
import 'package:project_for_class/user_page.dart';
import 'package:project_for_class/user_rankings.dart';
import 'api_service/api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'api_service/match_id_api.dart';
import 'api_service/odds_api.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController();
  int currentIndex = 0;

  bool authenticated = false;
  bool displayBets = false;
  bool selectedBet = false;
  bool userRankings = true;
  bool betsReady = false;

  String currentHome = "";
  String currentVisitor = "";

  late List<Scores>? _gameModel = [];
  late Future<List<Standings>?> _standings;
  late List<List<Odds>?>? _odds;
  late List<Standings>? awaitedStandings = [];
  List<MatchId>? _matchIds = [];
  late FirebaseFirestore db;
  var user = FirebaseAuth.instance.currentUser?.email;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _rank = db
      .collection('Standings')
      .orderBy("guessedRightPercentage", descending: true)
      .snapshots();

  // late Stream<QuerySnapshot<Map<String, dynamic>>> _rank = db.collection("users").snapshots();
  //     // .orderBy("guessedRightPercentage", descending: true)
  //     // .snapshots();

  @override
  void initState() {
    super.initState();
    _getGameIds();
    _getData();
    _getStandings();

    Timer(const Duration(seconds: 10), () {
      setState(() {
        betsReady = true;
      });
    });
    _getOdds();
    db = FirebaseFirestore.instance;
    if (FirebaseAuth.instance.currentUser != null) {
      authenticated = true;
    }
  }

  void _getData() async {
    _gameModel = (await nbaApi().getTodayGames());
    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getOdds() async {
    _odds = (await fetchOdds());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getStandings() async {
    _standings = nbaApi().getTeamsStandings();
    awaitedStandings = await _standings;
    (await _standings)
        ?.sort((a, b) => a.conference!.rank!.compareTo(b.conference!.rank!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<void> _getGameIds() async {
    _matchIds = (await fetchMatchToFetchMatchIdForOdds());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    //after match ids are fetched
    _getOdds();
  }

  _DashboardState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text('Dashboard'),
        actions: <Widget>[
          authenticated
              ? IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                  },
                )
              : TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
        ],
      ),
      body: _gameModel!.isNotEmpty ?
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'UPCOMING MATCHES',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontFamily: GoogleFonts.bebasNeue().fontFamily,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: _gameModel!.map((item) => GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  //margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule("${item.homeTeam?.name.toString()}", "${item.homeTeam?.id.toString()}"))),
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "${item.homeTeam?.name.toString()}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>  TeamSchedule("${item.homeTeam?.name.toString()}","${item.homeTeam?.id.toString()}")),
                                    );
                                  },
                                  child: Image.network(
                                    "${item.homeTeam?.logo.toString()}",
                                    width: 70,
                                    height: 50,
                                  ),
                                ),
                              ]
                            ),
                          ),
                          const Text("-"),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSchedule("${item.visitorTeam?.name.toString()}", "${item.visitorTeam?.id.toString()}"))),
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "${item.visitorTeam?.name.toString()}",
                                    textAlign: TextAlign.center,
                                  )
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>  TeamSchedule("${item.visitorTeam?.name.toString()}","${item.visitorTeam?.id.toString()}")),
                                    );
                                  },
                                  child: Image.network(
                                    "${item.visitorTeam?.logo.toString()}",
                                    width: 70,
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      item.home?.points == null ?
                        Row(
                          children: [
                            const Expanded(
                              flex: 0,
                              child: Text(""),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      //"${DateFormat.Hm().format(DateTime.parse(item.time!))} UTC",
                                      DateFormat.MMMd().format(DateTime.parse(item.time!).toLocal()),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      //"${DateFormat.Hm().format(DateTime.parse(item.time!))} UTC",
                                      DateFormat.Hm().format(DateTime.parse(item.time!).toLocal()),
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 0,
                              child: Text(""),
                            ),
                          ]
                        ) : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "${item.home?.points}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 0,
                                  child: Text(""),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "${item.visitor?.points}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    displayBets = !displayBets;
                  });
                },
              )).toList(),
            ),
            DotsIndicator(
              dotsCount: _gameModel!.length,
              position: currentIndex.toDouble(),
            ),
            if (!betsReady && displayBets) ...[
              const Card(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  height: 170,
                  width: 350,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ] else if (displayBets && !selectedBet) ...[
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      //game date
                      _odds?[currentIndex]![0].status == "NS"
                          ? const Text(
                              'Who will win?',
                              textAlign: TextAlign.right,
                            )
                          : const Text(
                              'Odds were',
                              textAlign: TextAlign.right,
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      //team names and score/game time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 100,
                            child: GestureDetector(
                              onTap: () {
                                  //change when user can make bet
                                if(_odds?[currentIndex]![0].status == "NS"){
                                  final userGameMap = <String, dynamic>{
                                    "gameId":
                                    _gameModel?[currentIndex].gameId,
                                    "teamName": _gameModel?[currentIndex]
                                        .homeTeam
                                        ?.name,
                                    "isFinished": false,
                                  };
                                  var userRef = db.collection("users")
                                      .doc(
                                      FirebaseAuth
                                          .instance.currentUser?.uid);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Bet on ${_gameModel?[currentIndex].homeTeam?.nickname}"),
                                        content: SizedBox(
                                          height: 20,
                                          child:
                                            Text("Chance ${_odds?[currentIndex]![0].homeOdds}"),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                                await db
                                                    .collection("predictedgames")
                                                    .doc(FirebaseAuth
                                                    .instance.currentUser?.uid)
                                                    .set(userGameMap)
                                                    .onError((e, _) => print(
                                                    "Error writing document: $e"));
                                                _gameModel?.removeAt(currentIndex);
                                            },
                                            child: Text("Bet"),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                } else {
                                  null;
                                }
                              },
                              child: Card(
                                color: Colors.white70,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${_gameModel?[currentIndex].homeTeam?.nickname}",
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${_odds?[currentIndex]![0].homeOdds}", // need to fix_odds.,_odds[0].homeOdds,
                                      style:
                                          const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: 160,
                            height: 100,
                            child: GestureDetector(
                              onTap: () {
                                if(_odds?[currentIndex]![0].status == "NS") {
                                  final userGameMap = <String, dynamic>{
                                    "gameId": _gameModel?[currentIndex].gameId,
                                    "teamName": _gameModel?[currentIndex].visitorTeam?.name,
                                    "isFinished": false,
                                  };
                                  var userRef = db.collection("users")
                                      .doc(
                                      FirebaseAuth
                                          .instance.currentUser?.uid);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Bet on ${_gameModel?[currentIndex].visitorTeam?.nickname}"),
                                          content: SizedBox(
                                            height: 20,
                                            child:
                                            Text("Chance ${_odds?[currentIndex]![0].awayOdds}"),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await db
                                                    .collection("predictedgames")
                                                    .doc(FirebaseAuth
                                                    .instance.currentUser?.uid)
                                                    .set(userGameMap)
                                                    .onError((e, _) => print(
                                                    "Error writing document: $e"));
                                                _gameModel?.removeAt(currentIndex);
                                              },
                                              child: Text("Bet"),
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                } else {
                                  null;
                                }
                              },
                              child: Card(
                                color: Colors.white70,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${_gameModel?[currentIndex].visitorTeam?.nickname}",
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${_odds?[currentIndex]![0].awayOdds}", // need to fix_odds.,
                                      style:
                                          const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                onTap: () {}),
            ],
            const SizedBox(height: 10),
            Container(
              height: 20,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                "Rankings",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontFamily: GoogleFonts.bebasNeue().fontFamily,
                ),
              ),
            ),
            if (userRankings) ...[
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  setState(() {
                    userRankings = false;
                  });
                },
                onTap: () {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => UserRankings()));
                },
                child: SizedBox(
                  height: displayBets ? 220 : 380,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.amber,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _rank,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot data =
                                      snapshot.data?.docs[index]
                                          as DocumentSnapshot<Object?>;
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    color: Colors.amber,
                                    child: Card(
                                      child: ListTile(
                                        leading: Text('${index + 1}'),
                                        title: Text('${data['email']}'),
                                        trailing: Text( "win % - ${data['guessedRightPercentage']}"),
                                      ),
                                    ),
                                  );
                                }
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  setState(() {
                    userRankings = true;
                  });
                },
                child: SizedBox(
                  height: displayBets ? 220 : 380,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.amberAccent,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: FutureBuilder(
                          future: _standings,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    color: Colors.amberAccent,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push((context), MaterialPageRoute(builder: (context) => TeamSchedule(snapshot.data[index].eastTeam.name.toString(), snapshot.data[index].eastTeam.id.toString())));
                                      },
                                      child: Card(
                                        child: ListTile(
                                          leading: Text(snapshot.data[index].conference.rank.toString()),
                                          title: Text(snapshot.data[index].eastTeam.name.toString()),
                                          subtitle: Text("${snapshot.data[index].win.total.toString()} - ${snapshot.data[index].loss.total.toString()}"),
                                          trailing: Text(snapshot.data[index].conference.name.toString().toUpperCase()),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ),
                ),
              )
            ]
          ],
        )
      : const Center(
          child: CircularProgressIndicator(),
        ),
    );
  }

  Future<List<List<Odds>?>?> fetchOdds() async {
    var headers = {
      'x-rapidapi-key': '1bb8997ee5e91a27b5b22bacc064405a',
      'x-rapidapi-host': 'v1.basketball.api-sports.io'
    };
    try {
      List<List<Odds>?> allOdds = [];
      for (int i = 0; i < _matchIds!.length; i++) {
        Response response = await get(
            //to change
            Uri.parse(
                'https://v1.basketball.api-sports.io/odds?league=12&season=2022-2023&game=${_matchIds![i].gameId}'),
            headers: headers);
        if (response.statusCode == 200) {
          var decodedResponse = jsonDecode(response.body)['response'];
          final oddsList =
              decodedResponse.map<Odds>((e) => Odds.fromJson(e)).toList();
          allOdds.add(oddsList);
        }
      }
      return allOdds;
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<List<MatchId>?> fetchMatchToFetchMatchIdForOdds() async {
    var headers = {
      'x-rapidapi-key': '1bb8997ee5e91a27b5b22bacc064405a',
      'x-rapidapi-host': 'v1.basketball.api-sports.io'
    };
    try {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      Response response = await get(
          //to change
          Uri.parse(
              'https://v1.basketball.api-sports.io/games?league=12&season=2022-2023&date=$date'),
          headers: headers);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body)['response'];
        final matchIdList =
            decodedResponse.map<MatchId>((e) => MatchId.fromJson(e)).toList();
        return matchIdList;
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
    return null;
  }
}
