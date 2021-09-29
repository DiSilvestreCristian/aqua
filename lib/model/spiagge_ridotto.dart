import 'dart:convert';

List<SpiaggiaRidotto> spiaggiaRidottoFromJson(String str) => List<SpiaggiaRidotto>.from(json.decode(str).map((x) => SpiaggiaRidotto.fromJson(x)));

String spiaggiaRidottoToJson(List<SpiaggiaRidotto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpiaggiaRidotto {
  SpiaggiaRidotto({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.lastCheck,
    required this.quality,
    required this.ostreopsis,
    required this.escherichia,
    required this.enterococcus,
  });

  String id;
  String name;
  Coordinates coordinates;
  int lastCheck;
  String quality;
  int ostreopsis;
  int escherichia;
  int enterococcus;

  factory SpiaggiaRidotto.fromJson(Map<String, dynamic> json) => SpiaggiaRidotto(
    id: json["id"],
    name: json["name"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    lastCheck: json["last_check"],
    quality: json["quality"],
    ostreopsis: json["ostreopsis"],
    escherichia: json["escherichia"],
    enterococcus: json["enterococcus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coordinates": coordinates.toJson(),
    "last_check": lastCheck,
    "quality": quality,
    "ostreopsis": ostreopsis,
    "escherichia": escherichia,
    "enterococcus": enterococcus,
  };
}

class Coordinates {
  Coordinates({
    required this.x,
    required this.y,
  });

  double x;
  double y;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    x: json["x"].toDouble(),
    y: json["y"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}
