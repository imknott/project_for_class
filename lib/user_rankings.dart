import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserRankings extends StatefulWidget {
  const UserRankings({Key? key}) : super(key: key);

  @override
  State<UserRankings> createState() => _UserRankingsState();
}

class _UserRankingsState extends State<UserRankings> {
  late FirebaseFirestore db;
  late FirebaseAuth _auth;

  @override
  void initState() {

    super.initState();
    db = FirebaseFirestore.instance;
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();

    _auth = FirebaseAuth.instance;
  }

  late List userList = ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Rankings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userList.isNotEmpty
            ? db.collection('Standings').orderBy("guessedRightPercentage", descending: true).snapshots()
            : db.collection("Standings").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data
                  ?.docs[index] as DocumentSnapshot<Object?>;
              return Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: ListTile(
                    tileColor: Colors.amber,
                    leading: Text("${data['email']}"),
                    title: Text('Correct Prediction %: ${data['guessedRightPercentage']}'),
                  ));
            },
          );
        },
      ),
    );
  }
}