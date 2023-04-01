import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/user_page.dart';
import 'package:project_for_class/fireStore_service.dart';
import 'package:project_for_class/match_page.dart';

import 'api_service.dart';

class MyDashPage extends StatefulWidget {
  const MyDashPage({super.key});

  @override
  State<MyDashPage> createState() => _MyDashPageState();
}

class _MyDashPageState extends State<MyDashPage> {
  late List<Scores>? _gameModel = [];
  late FirebaseAuth _auth;
  late FirebaseFirestore db;
  late var user;
  late var userInfo;
  late var docSnap;


  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    user = _auth.currentUser?.email;
    _getData();
    _getFirestoreData();
  }

  void _getFirestoreData() async {
    final ref = db.collection("users").doc("${_auth.currentUser?.uid}").withConverter(
      fromFirestore: UserFS.fromFirestore,
      toFirestore: (UserFS userInfo, _) => userInfo.toFirestore(),
    );
    docSnap = await ref.get();
    userInfo = docSnap.data(); // Convert to City object
    if (userInfo != null) {
      print(userInfo);
    } else {
      print("No such document.");
    }
  }


  void _getData() async {
    _gameModel = (await nbaApi().getTodayGames());

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Hello, $user"),
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
        body: _gameModel == null || _gameModel!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
              Container(

                child: Row(children: [
                  Text('Your total predicted wins ${userInfo.gamesPredictedCorrect} / ${userInfo.totalPredictions}'),
                  Text('Total predicted losses ${userInfo.gamesPredictedIncorrect} / ${userInfo.totalPredictions}'),
                ],),
              ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Upcoming Games',
                      style: TextStyle(color: Colors.amber, fontSize: 24),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.blueGrey,
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _gameModel!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {

                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Match(_gameModel![index].id.toString())));
                                },
                                child: Row(
                                children: [
                                  Column(children: [
                                    TextButton(
                                        onPressed: () => {},
                                        child: Text(
                                            "${_gameModel![index].homeTeam?.name.toString()}"),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                        )),
                                    Image.network(
                                      "${_gameModel![index].homeTeam?.logo.toString()}",
                                      width: 70,
                                      height: 50,
                                    ),
                                  ]),
                                  Text("vs"),
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () => {},
                                          child: Text(
                                              "${_gameModel![index].visitorTeam?.name.toString()}")),
                                      Image.network(
                                        "${_gameModel![index].visitorTeam?.logo.toString()}",
                                        width: 70,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
