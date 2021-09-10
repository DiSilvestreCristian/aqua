import 'package:aqua/spiagge_ridotto.dart';
import 'package:http/http.dart' as http;
import 'spiaggia.dart';

class Services {
  static const String url = 'https://pastebin.com/raw/2WAsKh2K';
  static const String urlRidotto = 'http://0fee-79-55-191-186.ngrok.io/AQUA-WebServer/public/spiagge';

  static Future<List<Spiaggia>> getSpiagge() async {
    try{
      final response = await http.get(Uri.parse(url));
      var x = response.body;
      if (200 == response.statusCode){
        final List<Spiaggia> spiagge = spiaggiaFromJson(response.body);
        return spiagge;
      }else{
        return <Spiaggia>[];
      }
    }catch(e){
      return <Spiaggia>[];
    }
  }

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

