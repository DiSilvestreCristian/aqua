import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:http/http.dart' as http;

class ServicesRidotto {
  static const String url = 'http://193.205.129.120:63434/spiagge';
  static const String urlRidotto = 'https://pastebin.com/raw/NW5RvE6X';
  static const String urlPrincipaliRidotto = 'https://pastebin.com/raw/g9FJ3SdB';

  static Future<List<SpiaggiaRidotto>> getSpiaggeRidotto() async {
    try{
      final response = await http.get(Uri.parse(urlRidotto));
      if (200 == response.statusCode){
        final List<SpiaggiaRidotto> spiaggeRidotto = spiaggiaRidottoFromJson(response.body);
        return spiaggeRidotto;
      }else{
        return <SpiaggiaRidotto>[];
      }
    }catch(e){
      return <SpiaggiaRidotto>[];
    }
  }
}

