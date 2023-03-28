
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
import 'package:project_for_class/test_data_retrieval.dart';
import 'package:project_for_class/user_page.dart';

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
  var _user = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? '/test' : '/newDash',
      routes: {
        '/sign-in': (context) {
          return LoginScreen();
        },
        '/test': (context){
          return const Home();
        },
        '/newDash': (context){
          return MyDashPage(title: '{$_user}');
        },
        //  '/forgot-password': (context) {
        //this will be created soon
        // },
        '/register': (context){
          return RegisterScreen(
          );
        },
        '/onboard': (context){
          return const OnboardingScreen();
        },
       '/user': (context){
          return const UserPage();
       }
      },
    );
  }
}
