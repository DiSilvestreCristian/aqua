//https://pastebin.com/raw/y5aVYmE0
import 'dart:convert';

List<Rilevazione> rilevazioneFromJson(String str) => List<Rilevazione>.from(json.decode(str).map((x) => Rilevazione.fromJson(x)));

String rilevazioneToJson(List<Rilevazione> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rilevazione {
  Rilevazione({
    required this.data,
    required this.value,
  });

  DateTime data;
  int value;

  factory Rilevazione.fromJson(Map<String, dynamic> json) => Rilevazione(
    data: DateTime.parse(json["data"]),
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
    "value": value,
  };
}