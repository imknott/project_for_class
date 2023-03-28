
//this file will hold color themes, and data constructs
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';
import 'package:project_for_class/schedule.dart';


class nbaApi {


  final String apiUrl =
      "https://api-nba-v1.p.rapidapi.com/teams?conference=East";

  static const headers = {
    'X-RapidAPI-Key': 'd45f0c70cfmsh782b01571662568p14e128jsn4b5d31ee0db8',
    'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com'
  };

// the west and east team class will hold the data for nba teams.


//this pulls a team from the eastern conference


  Future<List<EastTeam>> fetchEastTeam() async {
    var body;

    try {
      Response res = await get(Uri.parse(apiUrl), headers: headers);
      if (res.statusCode == 200) {
        var resMap = json.decode(res.body)['response'] as List;
        final modelList =
        resMap.map<EastTeam>((e) => EastTeam.fromJson(e)).toList();
        return modelList;
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<List<WestTeam>> fetchWestTeam() async {
    try {
      Response res = await get(
          Uri.parse('https://api-nba-v1.p.rapidapi.com/teams?conference=West'),
          headers: headers);
      if (res.statusCode == 200) {
        var resMap = json.decode(res.body)['response'] as List;
        final modelList =
        resMap.map<WestTeam>((e) => WestTeam.fromJson(e)).toList();
        return modelList;
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<List<Scores>> getTodayGames() async {
    try {
      Response res = await get(
          Uri.parse('https://api-nba-v1.p.rapidapi.com/games?date=2023-03-28'),
          headers: headers);
      if (res.statusCode == 200) {
        var homeMap = json.decode(res.body)['response'] as List;
        print(json.decode(res.body));
        final homeList =
        homeMap.map<Scores>((e) => Scores.fromJson(e)).toList();
        return homeList;
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }

  Future<List<Player>> getTeamPlayerInfo() async {
    try {
      Response res = await get(
          Uri.parse('https://api-nba-v1.p.rapidapi.com/players?season=2022&team=2'),
          headers: headers);
      if (res.statusCode == 200) {
        var homeMap = json.decode(res.body)['response'] as List;
        print(json.decode(res.body));
        final homeList =
        homeMap.map<Player>((e) => Player.fromJson(e)).toList();
        return homeList;
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("Failed to connect to API: $e");
    }
  }
}

class Scores {
  VisitorTeam? visitorTeam;
  HomeTeam? homeTeam;
  Visitors? visitor;
  Home? home;

  Scores({
    required this.visitorTeam,
    required this.homeTeam,
    required this.visitor,
    required this.home,
});
 factory Scores.fromJson(Map<String, dynamic> json) {
    return Scores(
      visitorTeam: VisitorTeam.fromJson(json['teams']['visitors']),
      homeTeam: HomeTeam.fromJson(json['teams']['home']),
      visitor: Visitors.fromJson(json['scores']['visitors']),
      home: Home.fromJson(json['scores']['home']),
    );
  }

  Map<String, dynamic> toJson() => {
   'visitorTeam': visitorTeam,
    'homeTeam': homeTeam,
    'visitor': visitor,
    'home': home,
  };

}

class Home{
  int? win;
  int? loss;
  int? points;

  Home({
    this.win,
    this.loss,
    this.points
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      win: json['win'],
      loss: json['loss'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'win': win,
        'loss': loss,
        'points': points,
      };

}

class Series {
  int? win;
  int? loss;

  Series({
    this.win,
    this.loss
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      win: json['win'],
      loss: json['loss'],
    );
  }
    Map<String, dynamic> toJson() =>
        {
          'win': win,
          'loss': loss,
        };
  }


class Visitors{
  int? win;
  int? loss;
  int? points;

  Visitors({
    this.win,
    this.loss,
    this.points,
});

  factory Visitors.fromJson(Map<String, dynamic> json) {
    return Visitors(
      win: json['win'],
      loss: json['loss'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() => {
    'win': win,
    'loss': loss,
    'points': points,
  };

}




//below are east and west team for nba

class WestTeam{
  final int? id;
  final String? name;
  final String? nickname;
  final String? code;
  final String? city;
  final String? logo;

  const WestTeam({
    this.id,
    this.name,
    this.nickname,
    this.code,
    this.city,
    this.logo,
  });

  factory WestTeam.fromJson(Map<String, dynamic> json) {
    return WestTeam(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      code: json['code'],
      city: json['city'],
      logo: json['logo'],

    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'nickname': nickname,
    'code': code,
    'city': city,
    'logo' : logo,
  };

}




class EastTeam {
  final int? id;
  final String? name;
  final String? nickname;
  final String? code;
  final String? city;
  final String? logo;

  const EastTeam({
    this.id,
     this.name,
    this.nickname,
     this.code,
     this.city,
    this.logo,
  });


  factory EastTeam.fromJson(Map<String, dynamic> json) {
    return EastTeam(
      id: json['id'],
      name: json['name'] ,
      nickname: json['nickname'] ,
      code: json['code'] ,
      city: json['city'] ,
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'nickname': nickname,
    'code': code,
    'city': city,
    'logo' : logo,
  };
}


class VisitorTeam {
  final int? id;
  final String? name;
  final String? nickname;
  final String? code;
  final String? city;
  final String? logo;

  const VisitorTeam({
    this.id,
    this.name,
    this.nickname,
    this.code,
    this.city,
    this.logo,
  });


  factory VisitorTeam.fromJson(Map<String, dynamic> json) {
    return VisitorTeam(
      id: json['id'],
      name: json['name'] ,
      nickname: json['nickname'] ,
      code: json['code'] ,
      city: json['city'] ,
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'nickname': nickname,
    'code': code,
    'city': city,
    'logo' : logo,
  };
}
class TeamPage{

}

class Player{
  String? firstname;
  String? lastName;
  int? id;
  Birthday? birthday;
  Height? height;
  Weight? weight;
  NBA? nba;
  String? college;
  String? affiliation;

    Player( {
    this.id,
    this.firstname,
    this.lastName,
    this.birthday,
    this.weight,
    this.height,
    this.nba,
    this.college,
    this.affiliation,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      weight: Weight.fromJson(json['weight']),
      height: Height.fromJson(json['height']),
      nba: NBA.fromJson(json['leagues']['standard']),
      birthday: Birthday.fromJson(json['birth']),
      id: json['id'],
      firstname: json['firstname'],
      lastName: json['lastname'],
      college: json['college'],
      affiliation: json['affiliation'],


    );
  }



}
class Leagues{
  int? jersey;
  bool? active;
  String? pos;

  Leagues({
    this.jersey,
    this.active,
    this.pos,
  });

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      jersey: json['jersey'],
      active: json['active'],
      pos: json['pos'],
    );
  }

  Map<String, dynamic> toJson() => {
    'jersey': jersey,
    'active': active,
    'pos': pos,
  };

  }

class Birthday{
  String? date;
  String? country;
  Birthday({
    this.date,
    this.country,
  });

  factory Birthday.fromJson(Map<String, dynamic> json) {
    return Birthday(
      date: json['date'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'country': country,
  };
}

class Height{
  String? feets;
  String? inches;
  String? meters;

  Height({
    this.feets,
    this.inches,
    this.meters
});

  factory Height.fromJson(Map<String, dynamic> json) {
    return Height(
      feets: json['feets'],
      inches: json['inches'],
      meters: json['meters'],
    );
  }

  Map<String, dynamic> toJson() => {
    'feets': feets,
    'inches': inches,
    'meter': meters
  };

}

class Weight{
  String? pounds;
  String? kilograms;

  Weight({
    this.pounds,
    this.kilograms,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      pounds: json['pounds'],
      kilograms: json['kilograms'],
    );
  }

  Map<String, dynamic> toJson() => {
    'pounds': pounds,
    'kilograms': kilograms,
  };

}

class NBA {
  int? start;
  int? pro;

  NBA({
    this.start,
    this.pro,
  });

  factory NBA.fromJson(Map<String, dynamic> json) {
    return NBA(
      start: json['start'],
      pro: json['pro'],
    );
  }

  Map<String, dynamic> toJson() => {
    'start': start,
    'pro': pro,
  };

}


class HomeTeam {
  final int? id;
  final String? name;
  final String? nickname;
  final String? code;
  final String? city;
  final String? logo;

  const HomeTeam({
    this.id,
    this.name,
    this.nickname,
    this.code,
    this.city,
    this.logo,
  });


  factory HomeTeam.fromJson(Map<String, dynamic> json) {
    return HomeTeam(
      id: json['id'],
      name: json['name'] ,
      nickname: json['nickname'] ,
      code: json['code'] ,
      city: json['city'] ,
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'nickname': nickname,
    'code': code,
    'city': city,
    'logo' : logo,
  };
}

