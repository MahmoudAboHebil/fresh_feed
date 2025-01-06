import 'package:fresh_feed/data/data.dart';

class NetworkInfoRepository {
  NetworkInfoRepository(this._networkInfoDataSource);
  final NetworkInfoDataSource _networkInfoDataSource;

  Stream<bool> get isConnectedStream =>
      _networkInfoDataSource.isConnectedStream;

  void dispose() {
    _networkInfoDataSource.dispose();
  }
}
