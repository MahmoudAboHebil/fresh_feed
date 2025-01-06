import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fresh_feed/data/data.dart';

class NetworkInfoDataSource {
  final ConnectivityPlusService _connectivity;
  StreamSubscription? _subscription;

  NetworkInfoDataSource(this._connectivity) {
    _subscription = _connectivity.connectivity.onConnectivityChanged
        .listen(_onConnectivityChanged);
  }

  final StreamController<bool> _networkController =
      StreamController<bool>.broadcast();

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
  }
}
