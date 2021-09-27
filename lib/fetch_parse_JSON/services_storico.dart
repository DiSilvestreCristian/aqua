import 'package:http/http.dart' as http;
import 'storico.dart';

class ServicesStorico {

  static const String url = 'https://pastebin.com/raw/y5aVYmE0';

  static Future<List<Rilevazione>> getStorico(/*String pollutant, String idSpiaggia*/) async {

    /*
    <--!! DA IMPLEMENTARE !!-->
    * if che dà 0,1,2 in base all'inquinante
    * composizione url
    */

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