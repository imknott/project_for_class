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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Rankings'),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('Standings').orderBy("guessedRightPercentage", descending: true).snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data
                        ?.docs[index] as DocumentSnapshot<Object?>;
                    return Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ListTile(
                          tileColor: Colors.amber,
                          leading: Text("${index+1}"),
                          title: Text("${data['email']}"),
                          trailing: Text('Prediction Rate %: ${data['guessedRightPercentage']*100}'),
                        )
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}