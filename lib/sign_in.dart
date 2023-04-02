

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_for_class/dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore db;
  String email = '';
  String password = '';



  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    db = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),backgroundColor: Colors.amber,),
      backgroundColor: Colors.blueGrey,
      body:Center(
        child:Container(
          padding: EdgeInsets.all(4),
          color: Colors.blueGrey,
          width: 400,
          height: 500,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'password',
                ),
              ),
              TextButton(
                  child: const Text('Login'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    elevation: 5,
                    backgroundColor: Colors.amber,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    //print("login with $email , $password");
                    try {

                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (_auth.currentUser != null) {
                        Navigator.pushNamed(context, "/dash");
                        //need to navigate to dash
                      } else {
                        print("Login failed");
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
              TextButton(
                child: const Text('Register'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}