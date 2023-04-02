import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/team_schedule.dart';
import 'package:project_for_class/user_page.dart';
import 'api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'odds_api.dart';
import 'package:project_for_class/fireStore_service.dart';


class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String email = "";
  late FirebaseFirestore db;
  late FirebaseAuth user;

  @override
  void initState() {
    super.initState();
    initFireStore();
  }
  void initFireStore() async {
    user = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (email != "" && email != null)
            ? db.collection('users')
            .where("searchFields", arrayContains: email)
            .snapshots()
            : db.collection("users").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
              return Card(
                child: Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: (){
                        final snackBar = SnackBar(
                          content: const Text(
                            "Add as a friend",
                          ),
                          action: SnackBarAction(
                            label: 'Yes',
                            onPressed: () async {
                              final friendMap = <String, dynamic>{
                                "friendEmail": data['email'],
                              };
                              await db.collection("friends").doc(user.currentUser?.uid).set(friendMap).onError((e, _) => print("Error writing document: $e"));
                              // Some code to undo the change.
                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(data['email'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

}