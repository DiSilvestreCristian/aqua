import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:http/http.dart' as http;

class ServicesRidotto {
  static const String url = 'http://193.205.129.120:63434/spiagge';
  static const String urlRidotto = 'https://pastebin.com/raw/NW5RvE6X';
  static const String urlStatico = 'https://pastebin.com/raw/eJjavwYQ';
  static Future<List<SpiaggiaRidotto>> getSpiaggeRidotto() async {
    try{
      final response = await http.get(Uri.parse(urlStatico));
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

