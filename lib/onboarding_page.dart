
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: Text("Sports Tracking app"),backgroundColor: Colors.amber,),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            width: 400,
            height: 400,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Track your favorite teams, players, and upcoming matches',textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20, color: Colors.amber),),
                Image.asset('images/flame-success.png'),
                TextButton(onPressed:() =>  Navigator.pushNamed(context, '/register'),style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  foregroundColor: Colors.black,
                  elevation: 5,
                  backgroundColor: Colors.amber,
                ), child: const Text("Register Now.")),
                TextButton(onPressed:() =>  Navigator.pushNamed(context, '/dash'),style: TextButton.styleFrom(
                  elevation: 5,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber,
                ), child: const Text("Register Later."))
                //want a text button
                //want another text button to sign in
              ],
            ),
          ),
        ),
      ),
    );
  }
}