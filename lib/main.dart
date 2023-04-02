import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_for_class/add_friend.dart';
import 'package:project_for_class/dashboard.dart';
import 'package:project_for_class/league_selection.dart';
import 'package:project_for_class/new_dash.dart';
import 'package:project_for_class/onboarding_page.dart';
import 'package:project_for_class/register_page.dart';
import 'package:project_for_class/sign_in.dart';
import 'package:project_for_class/user_page.dart';

import 'package:project_for_class/test_data_retrieval.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'firebase_options.dart';

//

//want to create a function that takes in the user info provided from the register function such as setting the
//Future<void> addUserInfo() async {}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final ranOnboarding = prefs.getBool('ranOnboarding') ?? false;
  ranOnboarding ? runApp(MyApp()) : runApp(Onboarding());
  //runApp(MyApp());
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sports Tracking app"),backgroundColor: Colors.amber,),
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState((){
              if(index == 2){
                isLastPage = true;
              }
              else {
                isLastPage = false;
              }
            });
          },
          children: [
            pageOne(),
            pageTwo(),
            pageThree(),
          ],
        ),
        bottomSheet: isLastPage ?
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber,
            minimumSize: const Size.fromHeight(80),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('ranOnboarding', true);
            runApp(MyApp());
            //Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => MyApp()));
          },
          child: const Text(
            'Get Started',
            style: TextStyle(fontSize: 24),
          ),
        ) : Container(
          color: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height:80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('SKIP'),
                onPressed: () {
                  controller.jumpToPage(2);
                },
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.black,
                    activeDotColor: Colors.white,
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn
                  ),
                ),
              ),
              TextButton(
                child: const Text('NEXT'),
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pageOne(){
    return Container(
        child: Center(
          child: Text(
          'Track your favorite teams and bet on which team will win.',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
    );
  }

  Widget pageTwo() {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerRight,
             child: Text(
                'Predict the results well enough and you could find yourself ranked #1',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ),
            ],
          ),
        )
    );
  }

  Widget pageThree(){
    return Container(
        child: Center(
          child: Text(
            'Create an account today',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        )
    );
  }
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
        '/addFriend': (context){
          return CloudFirestoreSearch();
        },
        '/register': (context) {
          return RegisterScreen();
        },
        '/onboard': (context) {
          return const OnboardingScreen();
        },
        '/dash': (context) {
          return Dashboard();
        },
        '/user': (context) {
          return UserPage();
        },
      },
    );
  }
}
