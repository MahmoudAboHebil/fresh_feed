import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPlusService {
  ConnectivityPlusService._();
  static final ConnectivityPlusService _instance = ConnectivityPlusService._();
  factory ConnectivityPlusService() {
    return _instance;
  }

  final Connectivity connectivity = Connectivity();
}
