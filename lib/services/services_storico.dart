import 'package:aqua/value/strings.dart';
import 'package:http/http.dart' as http;
import '../model/storico.dart';

class ServicesStorico {

  static const String urlProva = 'https://pastebin.com/raw/y5aVYmE0';
  static const String urlNull = 'https://pastebin.com/raw/9xqGCRAF';

  static Future<List<Rilevazione>> getStorico(String pollutant, String idSpiaggia) async {

    final idPollutant = pollutant == ostreopsisName ? 0 : (pollutant == escherichiaName ? 1 : 2);

    final url = "http://193.205.129.120:63434/spiagge/${idSpiaggia}/${idPollutant}";

    try{
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode){
        final List<Rilevazione> storico = rilevazioneFromJson(response.body);
        return storico;
      }else{
        return <Rilevazione>[];
      }
    }catch(e){
      return <Rilevazione>[];
    }
  }

}