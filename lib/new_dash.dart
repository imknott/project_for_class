import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/user_page.dart';


class NewDash extends StatelessWidget {
  NewDash({super.key});

  var user = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        textTheme: const TextTheme(
          // bodyText2: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
        ),
      ),
      home: MyDashPage(title: '{$user}'),
    );
  }
}

class MyDashPage extends StatefulWidget {
   MyDashPage({super.key, required this.title});
  final String title;


  @override
  State<MyDashPage> createState() => _MyDashPageState();
}

class _MyDashPageState extends State<MyDashPage> {

  var user = FirebaseAuth.instance.currentUser?.email;
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: Container(
          // Add padding around the search bar

          child: Row( children: [
          Text('Matches Happening Today'),

          ], ),
      ),
      );
  }
}