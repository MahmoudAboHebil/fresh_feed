import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fresh_feed/data/data.dart';

class NetworkInfoDataSource {
  final ConnectivityPlusService _connectivity;
  StreamSubscription? _subscription;

  NetworkInfoDataSource(this._connectivity) {
    print('=============================> newDataSource stream');
    _subscription = _connectivity.connectivity.onConnectivityChanged
        .listen(_onConnectivityChanged);
  }

  final StreamController<bool> _networkController =
      StreamController<bool>.broadcast();

  // i am using StreamController instead of just pass Stream<List<ConnectivityResult>>
  // because i want to get a boolean value
  Stream<bool> get isConnectedStream => _networkController.stream;

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final isConnected = results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi);
    _networkController.add(isConnected);
  }

  void dispose() {
    _subscription?.cancel();
    _networkController.close();
    print('=============================> DataSource stream close');
  }
}
