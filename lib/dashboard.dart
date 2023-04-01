import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/user_page.dart';
import 'api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'odds_api.dart';


class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController();
  bool authenticated = false;
  int currentIndex = 0;
  bool ready = false;
  final List<String> leagues = ['NBA', "NFL", "MLB", "MLS"];
  List<String> unfollowedLeagues = [];
  List<String> leagueLogo = ['images/Logo-NBA.png','images/nflLogo.png','images/mlbLogo.png','images/mlsCrestLogo.png'];

  var user = FirebaseAuth.instance.currentUser?.email;
  late List<Scores>? _gameModel = [];
  late Future<List<Odds>?> _odds;

  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
    _getOdds();
    ready = true;
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
    _odds = fetchOdds();

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  _DashboardState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text('Dashboard'),
        actions: <Widget>[
          authenticated ? IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserPage()));
            },
          ) : TextButton(
            child: const Text('Sign in',style: TextStyle(color: Colors.blueGrey),),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()));
            },
          ),
        ],
      ),
      body: _gameModel!.isNotEmpty ?
        Column(
          children: [
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'MATCHES TODAY',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30,
                    fontFamily: GoogleFonts.bebasNeue().fontFamily,
                  ),
                ),
              )
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
              items: _gameModel!
                  .map((item) => GestureDetector(
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
                                    onPressed: () => {},
                                    child: Text(
                                      "${item.homeTeam?.name.toString()}",
                                      textAlign: TextAlign.center,
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                  Image.network(
                                    "${item.homeTeam?.logo.toString()}",
                                    width: 70,
                                    height: 50,
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
                                    onPressed: () => {},
                                    child: Text(
                                      "${item.visitorTeam?.name.toString()}",
                                      textAlign: TextAlign.center,
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    )
                                  ),
                                  Image.network(
                                    "${item.visitorTeam?.logo.toString()}",
                                    width: 70,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${item.home?.points}",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1, child: Text(""),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${item.visitor?.points}",
                                  style: TextStyle(
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

                  },
                )
              ).toList(),
            ),
            DotsIndicator(
              dotsCount: _gameModel!.length,
              position: currentIndex.toDouble(),
            ),
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
                                  "${_gameModel?[0].homeTeam?.name}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "-", // need to fix_odds.,_odds[0].homeOdds,
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
                                  "${_gameModel?[0].visitorTeam?.name}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "-", // need to fix_odds.,
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
          ]
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
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
}
