import 'package:aqua/services/sercices_ridotto.dart';
import 'package:aqua/model/spiagge_ridotto.dart';

class SingletonSpiagge {
  static final SingletonSpiagge instance = new SingletonSpiagge._internal(ServicesRidotto.getSpiaggeRidotto());
  Future<List<SpiaggiaRidotto>> spiagge;
  factory SingletonSpiagge() => instance;

  SingletonSpiagge._internal(this.spiagge);
}


