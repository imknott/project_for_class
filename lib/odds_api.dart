import 'dart:convert';

List<Odds> oddsFromJson(String str) => List<Odds>.from(json.decode(str).map((x) => Odds.fromJson(x)));

//String oddsToJson(List<Odds> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//get match time, get team logos, get name of bookmaker, get first betting odds
class Odds {
  Odds({
    required this.gameId,
    required this.date,
    required this.time,
    required this.status,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeOdds,
    required this.awayOdds,
    required this.alreadyBet,
  });

  int gameId;
  String date;
  String time;
  String status;
  String homeLogo;
  String awayLogo;
  String homeOdds;
  String awayOdds;
  bool alreadyBet;

  factory Odds.fromJson(Map<String, dynamic> json) => Odds(
    gameId: json["game"]["id"],
    date: json["game"]["date"],
    time: json["game"]["time"],
    status: json["game"]["status"]["short"],
    homeLogo: json["game"]["teams"]["home"]["logo"],
    awayLogo: json["game"]["teams"]["away"]["logo"],
    homeOdds: json["bookmakers"][0]["bets"][0]["values"][0]["odd"],
    awayOdds: json["bookmakers"][0]["bets"][0]["values"][2]["odd"],
    alreadyBet: false,
  );
}