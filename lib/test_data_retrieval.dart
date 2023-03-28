
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'constants.dart';
import 'package:project_for_class/constants.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Player>? _teamModel = [];
  final String title = "East Teams";


  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _teamModel = (await nbaApi().getTeamPlayerInfo());



    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _teamModel == null || _teamModel!.isEmpty
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: _teamModel!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${_teamModel![index].firstname?.toString()}"),
                        Text("${_teamModel![index].lastName?.toString()}"),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Image.network(_teamModel![index].logo.toString(),width: 50,height: 50,),
                        Text("${_teamModel![index].height?.feets.toString()}"),
                        Text("${_teamModel![index].height?.inches.toString()}"),
                      ],
                    ),
                  ],
                ),
              );
            })
    );
  }
}

