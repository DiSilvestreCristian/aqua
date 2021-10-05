import 'package:aqua/value/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();
  static Future<void> openMap (String latitude, String longitude) async {
    String _googleUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    if (await canLaunch(_googleUrl)) {
      await launch(_googleUrl);
    } else {
      throw errorOpenMap;
    }
  }
}