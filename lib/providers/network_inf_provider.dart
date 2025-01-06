import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class NetworkInfoNotifier extends StreamNotifier<bool> {
  @override
  Stream<bool> build() {
    final network_repo_prov = ref.read(networkInfoRepoProvider);
    return network_repo_prov.isConnectedStream;
  }
}

final networkInfoStreamNotifierProv =
    StreamNotifierProvider<NetworkInfoNotifier, bool>(() {
  return NetworkInfoNotifier();
});
