import 'dart:convert';

List<Odds> oddsFromJson(String str) => List<Odds>.from(json.decode(str).map((x) => Odds.fromJson(x)));

//String oddsToJson(List<Odds> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//get match time, get team logos, get name of bookmaker, get first betting odds
class Odds {
  Odds({
    required this.date,
    required this.time,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeOdds,
    required this.awayOdds,
  });

  String date;
  String time;
  String homeLogo;
  String awayLogo;
  String homeOdds;
  String awayOdds;

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
    date: json["game"]["date"],
    time: json["game"]["time"],
    homeLogo: json["game"]["teams"]["home"]["logo"],
    awayLogo: json["game"]["teams"]["away"]["logo"],
    homeOdds: json["bookmakers"][0]["bets"][0]["values"][0]["odd"],
    awayOdds: json["bookmakers"][0]["bets"][0]["values"][1]["odd"],
  );
}