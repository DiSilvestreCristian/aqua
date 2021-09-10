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
  List<Value> ostreopsis;
  List<Value> escherichia;
  List<Value> enterococcus;

  factory Spiaggia.fromJson(Map<String, dynamic> json) => Spiaggia(
    id: json["id"],
    name: json["name"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    quality: json["quality"],
    ostreopsis: List<Value>.from(json["ostreopsis"].map((x) => Value.fromJson(x))),
    escherichia: List<Value>.from(json["escherichia"].map((x) => Value.fromJson(x))),
    enterococcus: List<Value>.from(json["enterococcus"].map((x) => Value.fromJson(x))),
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

class Value {
  Value({
    required this.date,
    required this.value,
  });

  int date;
  int value;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    date: json["date"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "value": value,
  };
}
