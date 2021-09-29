import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:http/http.dart' as http;

class ServicesRidotto {

  static const String urlRidotto = 'https://pastebin.com/raw/fh6ua3XZ';
  static const String urlRidottoProva = 'https://pastebin.com/raw/Y78dhSuj';
  static const String urlPrincipaliRidotto = 'https://pastebin.com/raw/GrPdtc3c';

  static Future<List<SpiaggiaRidotto>> getSpiaggeRidotto() async {
    try{
      final response = await http.get(Uri.parse(urlPrincipaliRidotto));
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

