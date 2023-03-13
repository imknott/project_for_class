import 'package:flutter/material.dart';

class LeagueSelectionScreen extends StatelessWidget {
  const LeagueSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('League Selector')),
      body: SafeArea(
          child: Center(
        child: Row(
          children: [
            Image.asset('images/Logo-NBA.png',width: 140, height: 140,),
            Image.asset('images/1200px-MLS_crest_logo_RGB_gradient.svg.png',width: 100, height: 100)
            //want a grid with the selection of NHL,NBA, MLS.
          ],
        ),
      )),
    );
  }
}
