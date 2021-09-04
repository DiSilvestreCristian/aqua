import 'package:aqua/services.dart';
import 'package:aqua/spiaggia.dart';
import 'package:singleton/singleton.dart';

class SingletonSpiagge {
  static Future<List<Spiaggia>> loadAppSettings() async {
    Future<List<Spiaggia>> _spiagge = Services.getSpiagge();
    return _spiagge;
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
}