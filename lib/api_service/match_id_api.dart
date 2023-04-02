import 'dart:convert';

List<MatchId> matchIdFromJson(String str) => List<MatchId>.from(json.decode(str).map((x) => MatchId.fromJson(x)));

//String oddsToJson(List<Odds> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//get match time, get team logos, get name of bookmaker, get first betting odds
class MatchId {
  MatchId({
    required this.gameId,
  });

  int gameId;

  factory MatchId.fromJson(Map<String, dynamic> json) => MatchId(
    gameId: json["id"],
  );
}