import 'package:aqua/services.dart';
import 'package:aqua/spiaggia.dart';

class InstanceSpiagge {
  static late List<Spiaggia> _spiagge;

  InstanceSpiagge(){
    Services.getSpiagge().then((spiagge) {
        _spiagge = spiagge;
    });
  }
}