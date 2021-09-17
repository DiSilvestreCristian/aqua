import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:http/http.dart' as http;

class ServicesRidotto {
  static const String urlRidotto = 'https://pastebin.com/raw/fh6ua3XZ';

  static Future<List<SpiaggiaRidotto>> getSpiaggeRidotto() async {
    try{
      final response = await http.get(Uri.parse(urlRidotto));
      var x = response.body;
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
