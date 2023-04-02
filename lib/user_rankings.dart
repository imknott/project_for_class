import 'package:flutter/material.dart';

class UserRankings extends StatefulWidget {
  const UserRankings({Key? key}) : super(key: key);

  @override
  State<UserRankings> createState() => _UserRankingsState();
}

class _UserRankingsState extends State<UserRankings> {

  late List userList = ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'];

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
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'How you compare',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: ListTile(
              tileColor: Colors.amber,
              leading: Text("user\'s rank"),
              title: Text('user\'s username'),
              subtitle: Text("win - lose percentage"),
              trailing: Text("total creds"),
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ListTile(
                    tileColor: Colors.amber,
                    leading: Text("${index+1}"),
                    title: Text('${userList[index]}'),
                    subtitle: Text("win - lose percentage"),
                    trailing: Text("total creds"),
                  ),
                );
              }
            ),
          ),
        ],
      ),
      //FutureBuilder(
      //     future: userList,
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //       if (snapshot.hasData) { //checks if the response returns valid data
      //         return ListView.builder(
      //             itemCount: snapshot.data.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 margin: EdgeInsets.fromLTRB(10, 0, 10,0),
      //                 color: Colors.amber,
      //                 child: Card(
      //                   child: ListTile(
      //                     leading: Text('ranking'),
      //                     title: Text('user name'),
      //                     subtitle: Text("win - lose percentage"),
      //                     trailing: Text("total creds"),
      //                   ),
      //                 ),
      //                 // // Column(
      //                 // //   children: [
      //                 // //     // Row(
      //                 // //     //   children: [
      //                 // //     //     Expanded(
      //                 // //     //       flex: 1,
      //                 // //     //       child: Text(snapshot.data[index].conference.rank.toString()),
      //                 // //     //     ),
      //                 // //     //     SizedBox(width: 10,),
      //                 // //     //     Expanded(
      //                 // //     //       flex: 2,
      //                 // //     //       child: Text(snapshot.data[index].eastTeam.name.toString())
      //                 // //     //     ),
      //                 // //     //     SizedBox(width: 10,),
      //                 // //     //     Expanded(
      //                 // //     //       flex: 1,
      //                 // //     //       child: Text("${snapshot.data[index].win.total.toString()} - ${snapshot.data[index].loss.total.toString()}"),
      //                 // //     //     ),
      //                 // //     //   ],
      //                 // //     // ),
      //                 // //   ],
      //                 // ),
      //               );
      //             }
      //         );
      //       }
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      // ),
    );
  }
}
