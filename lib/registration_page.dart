import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Image.asset('images/flame-success.png'),
            TextButton(onPressed:() =>  Navigator.pushNamed(context, '/register'),style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.amber,
            ), child: const Text("Register Now.")),
            TextButton(onPressed:() =>  Navigator.pushNamed(context, '/signin'),style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.amber,
            ), child: const Text("Register Later."))
            //want a text button
            //want another text button to sign in
          ],
        ),
      )),
    );
  }
}
