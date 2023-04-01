import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_for_class/dashboard.dart';
import 'package:project_for_class/league_selection.dart';
import 'package:project_for_class/new_dash.dart';
import 'package:project_for_class/onboarding_page.dart';
import 'package:project_for_class/register_page.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/user_page.dart';

import 'package:project_for_class/test_data_retrieval.dart';
import 'firebase_options.dart';

//

//want to create a function that takes in the user info provided from the register function such as setting the
//Future<void> addUserInfo() async {}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/onboard' : '/dash',
      routes: {
        '/sign-in': (context) {
          return LoginScreen();
        },
        //  '/forgot-password': (context) {
        //this will be created soon
        // },
        '/test': (context){
          return const Home();
        },
        '/register': (context) {
          return RegisterScreen();
        },
        '/onboard': (context) {
          return const OnboardingScreen();
        },
        '/dash': (context) {
          return MyDashPage();
        },
        '/user': (context) {
          return UserPage();
        },
      },
    );
  }
}
