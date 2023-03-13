import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_for_class/league_selection.dart';
import 'package:project_for_class/registration_page.dart';

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
    var providers = [EmailAuthProvider()];

    return MaterialApp(
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? '/onboard' : '/profile',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
              ForgotPasswordAction((context, email) {
                Navigator.pushNamed(
                  context,
                  '/forgot-password',
                  arguments: {'email': email},
                );
              }),
            ],
          );
        },
        '/forgot-password': (context) {
          return const ForgotPasswordScreen();
        },
        '/register': (context){
          return RegisterScreen(
            providers: providers,
          );
        },
        '/onboard': (context){
          return const OnboardingScreen();
        },
        '/league': (context){
          return const LeagueSelectionScreen();
        },
        '/profile': (context) {
          return ProfileScreen(
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
                FirebaseAuth.instance.currentUser == null;
              }),
            ],
          );
        },
      },
    );
  }
}
