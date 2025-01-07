import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

/*
i made the NetworkInfoNotifier autDispose to ensure that whenever we creating
new instance of networkInfoDsProvider we close its stream first
*/

class NetworkInfoNotifier extends AutoDisposeStreamNotifier<bool> {
  @override
  Stream<bool> build() {
    final network_repo_prov = ref.watch(networkInfoRepoProvider);
    return network_repo_prov.isConnectedStream;
  }
}

final networkInfoStreamNotifierProv =
    StreamNotifierProvider.autoDispose<NetworkInfoNotifier, bool>(() {
  return NetworkInfoNotifier();
});
