// To parse this JSON data, do
//
//     final spiaggia = spiaggiaFromJson(jsonString);

import 'dart:convert';

List<Spiaggia> spiaggiaFromJson(String str) => List<Spiaggia>.from(json.decode(str).map((x) => Spiaggia.fromJson(x)));

String spiaggiaToJson(List<Spiaggia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Spiaggia {
  Spiaggia({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.quality,
    required this.ostreopsis,
    required this.escherichia,
    required this.enterococcus,
  });

  String id;
  String name;
  Coordinates coordinates;
  String quality;
  List<Enterococcus> ostreopsis;
  List<Enterococcus> escherichia;
  List<Enterococcus> enterococcus;

  factory Spiaggia.fromJson(Map<String, dynamic> json) => Spiaggia(
    id: json["id"],
    name: json["name"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    quality: json["quality"],
    ostreopsis: List<Enterococcus>.from(json["ostreopsis"].map((x) => Enterococcus.fromJson(x))),
    escherichia: List<Enterococcus>.from(json["escherichia"].map((x) => Enterococcus.fromJson(x))),
    enterococcus: List<Enterococcus>.from(json["enterococcus"].map((x) => Enterococcus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coordinates": coordinates.toJson(),
    "quality": quality,
    "ostreopsis": List<dynamic>.from(ostreopsis.map((x) => x.toJson())),
    "escherichia": List<dynamic>.from(escherichia.map((x) => x.toJson())),
    "enterococcus": List<dynamic>.from(enterococcus.map((x) => x.toJson())),
  };
}

class Coordinates {
  Coordinates({
    required this.x,
    required this.y,
  });

  String x;
  String y;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    x: json["x"],
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}

class Enterococcus {
  Enterococcus({
    required this.date,
    required this.value,
  });

  int date;
  int value;

  factory Enterococcus.fromJson(Map<String, dynamic> json) => Enterococcus(
    date: json["date"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "value": value,
  };
}
