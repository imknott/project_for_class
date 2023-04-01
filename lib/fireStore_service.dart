import 'package:cloud_firestore/cloud_firestore.dart';

class UserFS {
  final String? UID;
  final String? email;
  final String? favoriteLeague;
  final int? gamesPredictedCorrect;
  final int? gamesPredictedIncorrect;
  final bool? isMember;
  final int? totalPredictions;

  UserFS({
    this.UID,
    this.email,
    this.favoriteLeague,
    this.gamesPredictedCorrect,
    this.gamesPredictedIncorrect,
    this.isMember,
    this.totalPredictions
  });

  factory UserFS.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserFS(
      UID: data?['UID'],
      email: data?['email'],
      favoriteLeague: data?['favoriteLeague'],
      gamesPredictedCorrect: data?['gamesPredictedCorrect'],
      gamesPredictedIncorrect: data?['gamesPredictedIncorrect'],
      isMember: data?['population'],
      totalPredictions: data?['totalPredictions'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (UID != null) "UID": UID,
      if (email != null) "email": email,
      if (favoriteLeague != null) "favoriteLeague" : favoriteLeague,
      if (gamesPredictedCorrect != null) "gamesPredictedCorrect": gamesPredictedCorrect,
      if (gamesPredictedIncorrect != null) "gamesPredictedIncorrect": gamesPredictedIncorrect,
      if (isMember != null) "isMember": isMember,
      if(totalPredictions != null) "totalPredictions": totalPredictions,
    };
  }
}


class StandingsTable {
  final String? uid;
  final double? totalGuessedPercentage;
  final double? standing;

  StandingsTable({
    this.uid,
    this.totalGuessedPercentage,
    this.standing,
  });

  factory StandingsTable.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return StandingsTable(
      uid: data?['uid'],
      totalGuessedPercentage: data?['totalGuessedPercentage'],
      standing: data?['standing']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (totalGuessedPercentage != null) "totalGuessedPercentage": totalGuessedPercentage,
      if (standing != null ) "standing": standing,
    };
  }
}
class PredictedTeam {
  final double? awayScore;
  final int? gameId;
  final double? homeScore;
  final String? homeTeam;
  final String? teamPredictedToWin;
  final String? vistorTeam;

  PredictedTeam({
    this.awayScore,
    this.gameId,
    this.homeScore,
    this.homeTeam,
    this.teamPredictedToWin,
    this.vistorTeam,
  });

  factory PredictedTeam.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return PredictedTeam(
        awayScore: data?['awayScore'],
        gameId: data?['gameId'],
        homeScore: data?['homeScore'],
      homeTeam: data?['homeTeam'],
      teamPredictedToWin: data?['teamPredictedToWin'],
      vistorTeam: data?['visitorTeam'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if(awayScore != null) "awayScore": awayScore,
      if(gameId != null) "awayScore": gameId,
      if(homeScore != null) "homeScore": homeScore,
      if(homeTeam != null) "homeTeam": homeTeam,
      if(teamPredictedToWin != null) "teamPredictedToWin": teamPredictedToWin,
      if(vistorTeam != null) "visitorTeam": vistorTeam,
    };
  }
}