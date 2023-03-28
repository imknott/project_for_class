import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/dashboard.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late FirebaseAuth _auth;
  String email = '';
  String password = '';
  String confirmPassword = '';
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: Text('Sport Tracking'),backgroundColor: Colors.amber,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(4),
          color: Colors.blueGrey,
          width: 400,
          height: 500,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Account to track your favorite teams, leagues and players.',textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20, color: Colors.amber),),
              Image.asset('images/flame-success.png'),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'email',
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
              ),
              TextField(
                enableSuggestions: true,
                autocorrect: true,
                obscureText: true,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'confirm password',
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    elevation: 5,
                    padding: EdgeInsets.all(2),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('create account'),
                  onPressed: () async {
                    //print("create account with $email , $password");
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if(_auth.currentUser != null){
                        Navigator.pushNamed(context, "/dash");

                      }else{
                        //do nothing
                      }

                    } catch (e) {
                      print(e);
                    }
                  }), TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blueAccent,
                    elevation: 5,
                    //padding: EdgeInsets.all(2),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Sign in'),
                  onPressed: () {
                    //print("create account with $email , $password");
                    Navigator.pushNamed(context, '/sign-in');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}