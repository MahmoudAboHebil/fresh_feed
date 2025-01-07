import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final networkInfoDsProvider = Provider.autoDispose((ref) {
  final connectivityPlusService = ConnectivityPlusService();
  final networkInfoDataSource = NetworkInfoDataSource(connectivityPlusService);
  ref.onDispose(() {
    networkInfoDataSource.dispose();
  });
  return networkInfoDataSource;
});
