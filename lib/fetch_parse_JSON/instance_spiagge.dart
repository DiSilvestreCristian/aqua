import 'package:aqua/fetch_parse_JSON/sercices_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
/*class SingletonSpiagge {
  late Future<List<Spiaggia>> _spiagge;

  static Future<SingletonSpiagge> loadAppSettings() {
    Future<SingletonSpiagge> singleton = new Future<SingletonSpiagge>();
    singleton._spiagge = Services.getSpiagge();
    return singleton;
  }
}

class HttpClient {
  final SingletonSpiagge spiagge;

  HttpClient(this.spiagge);
}

class FutureService {
  /// Factory method that reuse same instance automatically
  factory FutureService() => Singleton<FutureService>().instance;

  static Future<FutureService> createInstance() async {
    final singletonSpiagge = await Singleton<SingletonSpiagge>().ensuredInstance();

    final httpClient = HttpClient(singletonSpiagge);

    return FutureService._(httpClient);
  }

  final HttpClient httpClient;

  FutureService._(this.httpClient);

  getInstanceSpiagge(){
    List<Spiaggia> instance = httpClient.spiagge as List<Spiaggia>;
    return instance;
  }
}*/

class SingletonSpiagge {
  static final SingletonSpiagge theOne = new SingletonSpiagge._internal(ServicesRidotto.getSpiaggeRidotto());
  Future<List<SpiaggiaRidotto>> spiagge;
  factory SingletonSpiagge() => theOne;

  SingletonSpiagge._internal(this.spiagge);
}