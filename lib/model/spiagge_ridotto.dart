import 'dart:convert';

List<SpiaggiaRidotto> spiaggiaRidottoFromJson(String str) => List<SpiaggiaRidotto>.from(json.decode(str).map((x) => SpiaggiaRidotto.fromJson(x)));

String spiaggiaRidottoToJson(List<SpiaggiaRidotto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpiaggiaRidotto {
  SpiaggiaRidotto({
    required this.id,
    required this.comune,
    required this.descrizione,
    required this.coordinate,
    required this.qualita,
    required this.stazioneVicina,
    required this.ostreopsis,
    required this.escherichia,
    required this.enterococcus,
  });

  String id;
  String comune;
  String descrizione;
  Coordinate coordinate;
  String qualita;
  String stazioneVicina;
  int ostreopsis;
  int escherichia;
  int enterococcus;

  factory SpiaggiaRidotto.fromJson(Map<String, dynamic> json) => SpiaggiaRidotto(
    id: json["id"],
    comune: json["comune"],
    descrizione: json["descrizione"],
    coordinate: Coordinate.fromJson(json["coordinate"]),
    qualita: json["qualita"],
    stazioneVicina: json["stazione_vicina"] == null ? null : json["stazione_vicina"],
    ostreopsis: json["ostreopsis"] == null ? null : json["ostreopsis"],
    escherichia: json["escherichia"],
    enterococcus: json["enterococcus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comune": comune,
    "descrizione": descrizione,
    "coordinate": coordinate.toJson(),
    "qualita": qualita,
    "stazione_vicina": stazioneVicina == null ? null : stazioneVicina,
    "ostreopsis": ostreopsis == null ? null : ostreopsis,
    "escherichia": escherichia,
    "enterococcus": enterococcus,
  };
}

class Coordinate {
  Coordinate({
    required this.x,
    required this.y,
  });

  double x;
  double y;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
    x: json["x"].toDouble(),
    y: json["y"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}


