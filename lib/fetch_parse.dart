import 'package:http/http.dart' as http;

class ListaSpiagge {
 final List<Spiaggia> lista;

 ListaSpiagge({
   required this.lista,
 });
}

class Spiaggia {
  final Coordinates coordinates;
  final List<Values> escherichia;
  final List<Values> enterococcus;
  final String id;
  final String name;
  final List<Values> ostreopsis;
  final int quality;

  Spiaggia ({
    required this.coordinates,
    required this.escherichia,
    required this.enterococcus,
    required this.id,
    required this.name,
    required this.ostreopsis,
    required this.quality,
});
}

class Values {
  final int data;
  final int value;

  Values ({
    required this.data,
    required this.value,
  });
}

class Coordinates {
  final String x;
  final String y;

  Coordinates ({
    required this.x,
    required this.y,
  });
}