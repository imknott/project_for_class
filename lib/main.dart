import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() => runApp(const LeagueTable());

class LeagueTable extends StatefulWidget {
  const LeagueTable({Key? key}) : super(key: key);

  @override
  State<LeagueTable> createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}
