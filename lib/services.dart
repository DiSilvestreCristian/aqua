import 'package:http/http.dart' as http;
import 'spiaggia.dart';

class Services {
  static const String url = 'https://pastebin.com/raw/2WAsKh2K';
  static Future<List<Spiaggia>> getSpiagge() async {
    try{
      final response = await http.get(Uri.parse(url));
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
}

